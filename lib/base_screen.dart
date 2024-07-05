import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/login/view/login_screen.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/features/recipe_view/view/category_screen.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/widgets/dialogs/show_message.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, appState) {
        if (appState.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: context.l10n.loading,
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
