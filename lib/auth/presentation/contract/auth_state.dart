import "package:auth_form/auth/domain/validation/email_error.dart";
import "package:auth_form/auth/domain/validation/password_error.dart";
import "package:auth_form/auth/presentation/model/validation_status.dart";
import "package:equatable/equatable.dart";

final class AuthState extends Equatable {
  const AuthState({
    required this.email,
    required this.password,
    required this.emailValidationStatus,
    required this.passwordValidationStatus,
    this.emailInputStatus = ValidationStatus.none,
    this.passwordInputStatus = ValidationStatus.none,
  });

  final String email;
  final String password;
  final Map<EmailError, ValidationStatus> emailValidationStatus;
  final Map<PasswordError, ValidationStatus> passwordValidationStatus;
  final ValidationStatus emailInputStatus;
  final ValidationStatus passwordInputStatus;

  static const initial = AuthState(
    email: "",
    password: "",
    emailValidationStatus: {},
    passwordValidationStatus: {
      PasswordError.tooShort: ValidationStatus.none,
      PasswordError.noUpperLowerCase: ValidationStatus.none,
      PasswordError.noDigits: ValidationStatus.none,
    },
  );

  AuthState copyWith({
    String? email,
    String? password,
    Map<EmailError, ValidationStatus>? emailValidationStatus,
    Map<PasswordError, ValidationStatus>? passwordValidationStatus,
    ValidationStatus? emailInputStatus,
    ValidationStatus? passwordInputStatus,
  }) =>
      AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
        emailValidationStatus:
            emailValidationStatus ?? this.emailValidationStatus,
        passwordValidationStatus:
            passwordValidationStatus ?? this.passwordValidationStatus,
        emailInputStatus: emailInputStatus ?? this.emailInputStatus,
        passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        emailValidationStatus,
        passwordValidationStatus,
        emailInputStatus,
        passwordInputStatus,
      ];
}
