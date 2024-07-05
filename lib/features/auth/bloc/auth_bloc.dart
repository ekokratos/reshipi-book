import 'dart:async';

import 'package:auth_api/auth_api.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:get/get.dart';
import 'package:recipe_book/base_screen.dart';
import 'package:recipe_book/shared/models/dialog_message.dart';

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
    on<_AuthEventUserChanged>(_onUserChanged);
    _userSubscription = _authRepository.user.listen(
      (user) => add(_AuthEventUserChanged(user)),
    );

    on<AuthEventSignUp>(_onSignUp);
    on<AuthEventLogOut>(_onLogOut);
    on<AuthEventPasswordReset>(_onPasswordReset);
  }
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AuthEventUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthStateAuthenticated(
              user: event.user,
              isLoading: false,
            )
          : const AuthStateUnauthenticated(
              isLoading: false,
            ),
    );
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

  void _onLogOut(
    AuthEventLogOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthStateUnauthenticated(isLoading: true));

    try {
      await _authRepository.logOut();
      Get.offAll(() => const BaseScreen());
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

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
