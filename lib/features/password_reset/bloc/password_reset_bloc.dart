import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  PasswordResetBloc() : super(PasswordResetInitial()) {
    on<PasswordResetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
