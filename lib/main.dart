import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/view/login_screen.dart';
import 'package:recipe_book/shared/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reshipi Book',
      theme: appTheme(),
      home: const LoginScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
