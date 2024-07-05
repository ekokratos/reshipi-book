part of 'password_reset_bloc.dart';

sealed class PasswordResetState extends Equatable {
  const PasswordResetState();
  
  @override
  List<Object> get props => [];
}

final class PasswordResetInitial extends PasswordResetState {}
