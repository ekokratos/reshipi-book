import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/shared/theme/style.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name =
        context.select((AuthBloc bloc) => bloc.state.user?.displayName ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $name!'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
