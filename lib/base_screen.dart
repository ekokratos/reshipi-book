import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/features/login/view/login_screen.dart';
import 'package:recipe_book/features/category/view/category_screen.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isLoading != current.isLoading,
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen.instance().show(
            context: context,
            text: context.l10n.loading,
          );
        } else {
          LoadingScreen.instance().hide();
        }

        if (state.authException != null) {
          showAuthError(
            authException: state.authException,
            context: context,
          );
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
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
