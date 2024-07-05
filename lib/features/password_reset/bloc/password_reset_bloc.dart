import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_input/form_input.dart';
import 'package:formz/formz.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc({
    required AuthRepository authRepository,
    required Email email,
  })  : _authRepository = authRepository,
        super(PasswordResetState(email: email, isValid: email.isValid)) {
    on<PasswordResetEmailChanged>(_onEmailChanged);
    on<PasswordResetRequested>(_onPasswordResetRequested);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    PasswordResetEmailChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        isValid: Formz.validate([email]),
        email: email,
      ),
    );
  }

  void _onPasswordResetRequested(
    PasswordResetRequested event,
    Emitter<PasswordResetState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.resetPassword(email: state.email.value);
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
        ),
      );
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          authException: e,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(status: FormzSubmissionStatus.failure),
      );
    }
  }
}
