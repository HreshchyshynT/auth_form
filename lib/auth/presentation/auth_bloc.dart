import "package:auth_form/auth/domain/validation/email_validator.dart";
import "package:auth_form/auth/domain/validation/password_validator.dart";
import "package:auth_form/auth/presentation/contract/auth_event.dart";
import "package:auth_form/auth/presentation/contract/auth_state.dart";
import "package:auth_form/auth/presentation/model/validation_status.dart";
import "package:bloc_concurrency/bloc_concurrency.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<SignUpTap>(_onSignUpTap, transformer: droppable());
  }

  final _passwordValidator = PasswordValidator();
  final _emailValidator = EmailValidator();

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    final emailError = _emailValidator.validate(event.email);
    emit(
      state.copyWith(
        email: event.email,
        emailValidationStatus: {},
        passwordValidationStatus: state.passwordValidationStatus.map(
          (key, value) => MapEntry(
            key,
            value == ValidationStatus.invalid ? ValidationStatus.none : value,
          ),
        ),
        emailInputStatus:
            emailError == null ? ValidationStatus.valid : ValidationStatus.none,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    final passwordErrors = _passwordValidator.validate(event.password);
    emit(
      state.copyWith(
        password: event.password,
        emailValidationStatus: {},
        passwordValidationStatus: state.passwordValidationStatus.map(
          (key, value) => MapEntry(
            key,
            passwordErrors?.contains(key) == true
                ? ValidationStatus.none
                : ValidationStatus.valid,
          ),
        ),
        passwordInputStatus: passwordErrors == null
            ? ValidationStatus.valid
            : ValidationStatus.none,
      ),
    );
  }

  void _onSignUpTap(SignUpTap event, Emitter<AuthState> emit) {
    final emailError = _emailValidator.validate(state.email);
    emit(
      state.copyWith(
        emailValidationStatus: {
          if (emailError != null) emailError: ValidationStatus.invalid,
        },
        passwordValidationStatus: state.passwordValidationStatus.map(
          (key, value) => MapEntry(
            key,
            value == ValidationStatus.valid
                ? ValidationStatus.valid
                : ValidationStatus.invalid,
          ),
        ),
        emailInputStatus: emailError == null
            ? ValidationStatus.valid
            : ValidationStatus.invalid,
        passwordInputStatus: state.passwordValidationStatus.values
                .any((status) => status == ValidationStatus.none)
            ? ValidationStatus.invalid
            : ValidationStatus.valid,
      ),
    );
  }
}
