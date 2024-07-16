import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_input/form_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/features/sign_up/bloc/sign_up_bloc.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignUpBloc(authRepository: context.read<AuthRepository>()),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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
        if (state.status.isSuccess) {
          Get.back();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top),
                const Align(
                  alignment: Alignment.topLeft,
                  child: BackButton(color: kPrimaryColor),
                ),
                Hero(
                  tag: 'chef_image',
                  child: SvgPicture.asset(
                    'assets/svgs/chef.svg',
                    height: Get.height * 0.25,
                  ),
                ),
                const SizedBox(height: 30),
                const _NameInput(),
                const SizedBox(height: 20),
                const _EmailInput(),
                const SizedBox(height: 20),
                const _PasswordInput(),
                const SizedBox(height: 10),
                const _PasswordIndicator(),
                const SizedBox(height: 8),
                Text(
                  context.l10n.passwordStrength,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: kSecondaryTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 30),
                const _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: SolidButton(
            onPressed: state.isValid && !state.status.isInProgressOrSuccess
                ? () {
                    context.read<SignUpBloc>().add(const SignUpSubmitted());
                  }
                : null,
            text: context.l10n.signUp,
          ),
        );
      },
    );
  }
}

class _PasswordIndicator extends StatelessWidget {
  const _PasswordIndicator();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
          previous.passwordStrengthLevel != current.passwordStrengthLevel,
      builder: (context, state) {
        return Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 35,
                height: 2.5,
                color: (index + 1) <= state.passwordStrengthLevel
                    ? kPrimaryColor
                    : kPrimaryColor.withOpacity(0.4),
              ),
            ),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                context.read<SignUpBloc>().add(const SignUpPasswordToggled());
              },
              child: const Icon(
                Icons.remove_red_eye_outlined,
                color: kTextFieldPrefixColor,
              ),
            ),
            errorText: state.password.displayError?.text(),
            onChanged: (value) {
              context.read<SignUpBloc>().add(SignUpPasswordChanged(value));
            },
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
    return BlocBuilder<SignUpBloc, SignUpState>(
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
                context.read<SignUpBloc>().add(SignUpEmailChanged(value)),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          label: context.l10n.name,
          hintText: 'John Doe',
          keyboardType: TextInputType.name,
          errorText: state.name.displayError?.text(),
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(value)),
        );
      },
    );
  }
}
