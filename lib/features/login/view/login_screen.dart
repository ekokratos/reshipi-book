import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:form_input/form_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/features/login/bloc/login_bloc.dart';
import 'package:recipe_book/features/password_reset/view/password_reset_screen.dart';
import 'package:recipe_book/features/sign_up/view/sign_up_screen.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/clickable_text.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(authRepository: context.read<AuthRepository>()),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isInProgress) {
          LoadingScreen.instance().show(
            context: context,
            text: context.l10n.loading,
          );
        } else {
          LoadingScreen.instance().hide();
        }

        if (state.status.isFailure) {
          showAuthError(
            authException: state.authException,
            context: context,
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Hero(
                  tag: 'chef_image',
                  child: SvgPicture.asset('assets/svgs/chef.svg'),
                ),
                const SizedBox(height: 40),
                const _EmailInput(),
                const SizedBox(height: 20),
                const _PasswordInput(),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                    tag: 'forgot_password',
                    child: ClickableText(
                      text: l10n.forgotPasswordBtn,
                      onTap: () {
                        Get.to(
                          () => PasswordResetScreen(
                            email: context.read<LoginBloc>().state.email,
                            loginBloc: context.read<LoginBloc>(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const _LoginButton(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.noAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    ClickableText(
                      text: l10n.signUp,
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

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: SolidButton(
            onPressed: state.isValid && !state.status.isInProgressOrSuccess
                ? () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  }
                : null,
            text: context.l10n.login,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          (previous.password != current.password) ||
          (previous.isPasswordVisible != current.isPasswordVisible),
      builder: (context, state) {
        return Hero(
          tag: 'password',
          child: CustomTextField(
            label: context.l10n.password,
            obscureText: !state.isPasswordVisible,
            suffixIcon: GestureDetector(
              excludeFromSemantics: true,
              onTap: () {
                context.read<LoginBloc>().add(const LoginPasswordToggled());
              },
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: kTextFieldPrefixColor,
              ),
            ),
            errorText:
                state.password.displayError == PasswordValidationError.empty
                    ? 'Enter password'
                    : null,
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Hero(
          tag: 'email',
          child: CustomTextField(
            initialValue: state.email.value,
            label: context.l10n.email,
            hintText: 'abcd@gmail.com',
            keyboardType: TextInputType.emailAddress,
            errorText: state.email.displayError?.text(),
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginEmailChanged(value)),
          ),
        );
      },
    );
  }
}
