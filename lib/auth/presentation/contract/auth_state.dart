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
  });

  final String email;
  final String password;
  final Map<EmailError, ValidationStatus> emailValidationStatus;
  final Map<PasswordError, ValidationStatus> passwordValidationStatus;

  bool get isPasswordValid => !passwordValidationStatus.values
      .any((status) => status == ValidationStatus.invalid);

  bool get isEmailValid => !emailValidationStatus.values
      .any((status) => status == ValidationStatus.invalid);

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
  }) =>
      AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
        emailValidationStatus:
            emailValidationStatus ?? this.emailValidationStatus,
        passwordValidationStatus:
            passwordValidationStatus ?? this.passwordValidationStatus,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        emailValidationStatus,
        passwordValidationStatus,
      ];
}
