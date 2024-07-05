import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_input/form_input.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/widgets/show_auth_error.dart';
import 'package:recipe_book/features/password_reset/bloc/password_reset_bloc.dart';
import 'package:recipe_book/l10n/l10n.dart';
import 'package:recipe_book/shared/models/dialog_message.dart';
import 'package:recipe_book/shared/theme/style.dart';
import 'package:recipe_book/shared/widgets/custom_text_field.dart';
import 'package:recipe_book/shared/widgets/dialogs/show_message.dart';
import 'package:recipe_book/shared/widgets/loading/loading_screen.dart';
import 'package:recipe_book/shared/widgets/solid_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key, required this.email});

  final Email email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordResetBloc(
        email: email,
        authRepository: context.read<AuthRepository>(),
      ),
      child: const PasswordResetView(),
    );
  }
}

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<PasswordResetBloc, PasswordResetState>(
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

        final authError = state.authException;
        if (state.status.isFailure && authError != null) {
          showAuthError(
            authException: authError,
            context: context,
          );
        }

        if (state.status.isSuccess) {
          showMessage(
            context: context,
            dialogMessage: const DialogMessage(
              title: 'Password Reset',
              message:
                  'Password reset link has been sent to your email. Please check the spam folder.',
            ),
          ).then((value) => Get.back());
        }
      },
      child: Scaffold(
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
                const _EmailInput(),
                const SizedBox(height: 30),
                const _PasswordResetButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordResetButton extends StatelessWidget {
  const _PasswordResetButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
      builder: (context, state) {
        return SolidButton(
          onPressed: state.isValid && !state.status.isInProgressOrSuccess
              ? () {
                  context
                      .read<PasswordResetBloc>()
                      .add(const PasswordResetRequested());
                }
              : null,
          text: context.l10n.resetPassword,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
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
            onChanged: (value) => context
                .read<PasswordResetBloc>()
                .add(PasswordResetEmailChanged(value)),
          ),
        );
      },
    );
  }
}
