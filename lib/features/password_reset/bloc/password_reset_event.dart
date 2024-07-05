part of 'password_reset_bloc.dart';

sealed class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

final class PasswordResetEmailChanged extends PasswordResetEvent {
  const PasswordResetEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordResetRequested extends PasswordResetEvent {
  const PasswordResetRequested();
}
