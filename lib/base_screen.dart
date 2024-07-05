import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/login/view/login_screen.dart';
import 'package:recipe_book/features/recipe_view/view/category_screen.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
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
