import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:recipe_book/features/auth/models/auth_exception.dart';
import 'package:recipe_book/main.dart';
import 'package:recipe_book/shared/models/dialog_message.dart';
import 'package:recipe_book/features/auth/repository/auth_reppository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          const AuthStateUnauthenticated(
            isLoading: false,
          ),
        ) {
    on<AuthEventInitialize>(_onAuthInitialize);
    on<AuthEventSignUp>(_onSignUp);
    on<AuthEventLogIn>(_onLogIn);
    on<AuthEventLogOut>(_onLogOut);
    on<AuthEventPasswordReset>(_onPasswordReset);
  }

  void _onAuthInitialize(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) {
    // get the current user
    final user = _authRepository.currentUser;
    if (user == null) {
      emit(
        const AuthStateUnauthenticated(
          isLoading: false,
        ),
      );
    } else {
      emit(
        AuthStateAuthenticated(
          user: user,
          isLoading: false,
        ),
      );
    }
  }

  void _onSignUp(
    AuthEventSignUp event,
    Emitter<AuthState> emit,
  ) async {
    // start loading
    emit(
      const AuthStateUnauthenticated(isLoading: true),
    );

    try {
      await _authRepository.signUp(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      emit(
        AuthStateAuthenticated(
          user: _authRepository.currentUser!,
          isLoading: false,
        ),
      );
    } on AuthException catch (e) {
      emit(
        AuthStateUnauthenticated(
          isLoading: false,
          authException: e,
        ),
      );
    }
  }

  void _onLogIn(
    AuthEventLogIn event,
    Emitter<AuthState> emit,
  ) async {
    // start loading
    emit(
      const AuthStateUnauthenticated(isLoading: true),
    );

    try {
      await _authRepository.logInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(
        AuthStateAuthenticated(
          user: _authRepository.currentUser!,
          isLoading: false,
        ),
      );
    } on AuthException catch (e) {
      emit(
        AuthStateUnauthenticated(
          isLoading: false,
          authException: e,
        ),
      );
    }
  }

  void _onLogOut(
    AuthEventLogOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateUnauthenticated(isLoading: true));

    try {
      await _authRepository.logOut();
      Get.offAll(const BaseScreen());
      emit(const AuthStateUnauthenticated(isLoading: false));
    } on AuthException catch (e) {
      emit(
        AuthStateUnauthenticated(
          isLoading: false,
          authException: e,
        ),
      );
    }
  }

  void _onPasswordReset(
    AuthEventPasswordReset event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthStateUnauthenticated(
        isLoading: true,
      ),
    );
    try {
      await _authRepository.resetPassword(email: event.email);
      emit(
        const AuthStateUnauthenticated(
          isLoading: false,
          dialogMessage: DialogMessage(
            title: 'Password Reset',
            message:
                'Password reset link has been sent to your email. Please check the spam folder.',
          ),
        ),
      );
      Get.back();
    } on AuthException catch (e) {
      emit(
        AuthStateUnauthenticated(
          isLoading: false,
          authException: e,
        ),
      );
    }
  }
}
