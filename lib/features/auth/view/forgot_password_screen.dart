import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/bloc/auth_bloc.dart';
import 'package:recipe_book/l10n/localization.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/utility/validation.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        title: Hero(
          tag: 'forgot_password',
          child: Text(
            Localization.of(context)!.pw_forgot_message,
            style: Theme.of(context).textTheme.headline1,
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
                  Localization.of(context)!.pw_forgot_message,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(height: 10),
                Hero(
                  tag: 'email',
                  child: CustomTextField(
                    controller: emailController,
                    label: Localization.of(context)!.mail,
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
                  text: Localization.of(context)!.pw_reset_message,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
