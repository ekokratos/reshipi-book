import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_input/form_input.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginPasswordToggled>(_onPasswordToggled);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        isValid: Formz.validate([email]) && state.password.value.isNotEmpty,
        email: email,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email]) && event.password.isNotEmpty,
      ),
    );
  }

  void _onPasswordToggled(
    LoginPasswordToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await _authRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
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
