import 'package:accessibility_tools/accessibility_tools.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth_api/firebase_auth_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_recipes_api/firebase_recipes_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:recipe_book/base_screen.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/shared/theme/app_theme.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          create: (context) => AuthRepository(authApi: FirebaseAuthApi()),
        ),
        RepositoryProvider(
          create: (context) =>
              RecipesRepository(recipesApi: FirebaseRecipesApi()),
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
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: context.read<AuthRepository>(),
      )..add(const AuthEventInitialize()),
      child: GetMaterialApp(
        // builder: (context, child) => AccessibilityTools(child: child),
        title: 'Reshipi Book',
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const BaseScreen(),
      ),
    );
  }
}
