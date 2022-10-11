import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/features/auth/view/forgot_password_screen.dart';
import 'package:recipe_book/features/auth/view/sign_up_screen.dart';
import 'package:recipe_book/l10n/localization.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/clickable_text.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Hero(
                  tag: 'chef_image',
                  child: SvgPicture.asset('assets/svgs/chef.svg'),
                ),
                const SizedBox(height: 40),
                Hero(
                  tag: 'email',
                  child: CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'abcd@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        Validation.validateEmail(value: value),
                  ),
                ),
                const SizedBox(height: 20),
                Hero(
                  tag: 'password',
                  child: CustomTextField(
                    controller: _passwordController,
                    label: Localization.of(context)!.pw,
                    obscureText: _isPasswordVisible,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: kTextFieldPrefixColor,
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return Localization.of(context)!.pw_enter;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: 'forgot_password',
                    child: ClickableText(
                      text: Localization.of(context)!.pw_forgot_title,
                      onTap: () {
                        Get.to(() => ForgotPasswordScreen());
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: SolidButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                              AuthEventLogIn(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    text: Localization.of(context)!.login,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Localization.of(context)!.new_account,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ClickableText(
                      text: Localization.of(context)!.sign_up,
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
