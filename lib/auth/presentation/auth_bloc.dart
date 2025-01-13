import "package:auth_form/auth/presentation/contract/auth_event.dart";
import "package:auth_form/auth/presentation/contract/auth_state.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpTap>(_onSignUpTap);
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onSignUpTap(SignUpTap event, Emitter<AuthState> emit) {}
}
