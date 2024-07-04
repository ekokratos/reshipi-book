import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        title: Hero(
          tag: 'forgot_password',
          child: Text(
            l10n.forgotPasswordAppBarTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/svgs/forgot_password.svg',
                  height: Get.height * 0.25,
                ),
                const SizedBox(height: 35),
                Text(
                  l10n.passwordRecovery,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: 'email',
                  child: CustomTextField(
                    controller: emailController,
                    label: l10n.email,
                    hintText: 'abcd@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        Validation.validateEmail(value: value),
                  ),
                ),
                const SizedBox(height: 30),
                SolidButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.read<AuthBloc>().add(
                            AuthEventPasswordReset(email: emailController.text),
                          );
                    }
                  },
                  text: l10n.resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
