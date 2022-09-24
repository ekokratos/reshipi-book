import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/view/sign_up_screen.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/clickable_text.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = true;

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

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
                    controller: emailController,
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
                    controller: passwordController,
                    label: 'Password',
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
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.topRight,
                  child: ClickableText(
                    text: 'Forgot password?',
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: SolidButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        //Go to category screen
                      }
                    },
                    text: 'Login',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    ClickableText(
                      text: 'Sign Up',
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
