import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = true;
  int _passwordStrength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                const Align(
                    alignment: Alignment.topLeft,
                    child: BackButton(color: kPrimaryColor)),
                Hero(
                  tag: 'chef_image',
                  child: SvgPicture.asset(
                    'assets/svgs/chef.svg',
                    height: Get.height * 0.25,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: nameController,
                  label: 'Name',
                  hintText: 'John Doe',
                  keyboardType: TextInputType.name,
                  validator: (value) => Validation.validateName(value),
                ),
                const SizedBox(height: 20),
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
                    onChanged: (value) {
                      setState(() {
                        _passwordStrength = _passwordStrengthLevel(value);
                      });
                    },
                    validator: Validation.validatePassword,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 35,
                        height: 2.5,
                        color: (index + 1) <= _passwordStrength
                            ? kPrimaryColor
                            : kPrimaryColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your password must be 8 or more characters long and contain a mix of upper and lower case letters, numbers and symbols.',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: kSecondaryTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: SolidButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                              AuthEventSignUp(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    text: 'Sign Up',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _passwordStrengthLevel(String password) {
    int strength = 0;
    RegExp lowercaseCheck = RegExp(r'[a-z]');
    RegExp uppercaseCheck = RegExp(r'[A-Z]');
    RegExp numberCheck = RegExp(r'[0-9]');
    RegExp symbolCheck = RegExp(r'[!"#$%&()*+,-./:;<=>?@[\]^_`{|}~]');

    if (password.isEmpty || password.length < 8) {
      strength = 0;
    } else {
      if (password.length >= 8) {
        strength++;
      }
      if (password.contains(lowercaseCheck)) {
        strength++;
      }
      if (password.contains(uppercaseCheck)) {
        strength++;
      }
      if (password.contains(numberCheck)) {
        strength++;
      }
      if (password.contains(symbolCheck)) {
        strength++;
      }
    }
    return strength;
  }
}
