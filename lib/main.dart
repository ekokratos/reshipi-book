import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/shared/repository/auth_reppository.dart';
import 'package:recipe_book/features/auth/view/login_screen.dart';
import 'package:recipe_book/features/recipe_view/views/category_screen.dart';
import 'package:recipe_book/shared/repository/recipe_repository.dart';
import 'package:recipe_book/shared/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/shared/widgets/dialogs/show_message.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => RecipeRepository(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          )..add(const AuthEventInitialize()),
        ),
      ],
      child: GetMaterialApp(
        title: 'Reshipi Book',
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        home: const BaseNavScreen(),
      ),
    );
  }
}

class BaseNavScreen extends StatelessWidget {
  const BaseNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, appState) {
        if (appState.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: 'Loading...',
          );
        } else {
          LoadingScreen.instance().hide();
        }

        final authError = appState.authException;
        if (authError != null) {
          showAuthError(
            authException: authError,
            context: context,
          );
        }

        final dialogMessage = appState.dialogMessage;
        if (dialogMessage != null) {
          showMessage(
            context: context,
            dialogMessage: dialogMessage,
          );
        }
      },
      builder: (context, appState) {
        switch (appState.status) {
          case AuthStatus.authenticated:
            return const CategoryScreen();
          case AuthStatus.unauthenticated:
            return const LoginScreen();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
