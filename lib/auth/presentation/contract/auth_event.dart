sealed class AuthEvent {
  factory AuthEvent.emailChanged(String email) = EmailChanged._;
  factory AuthEvent.passwordChanged(String password) = PasswordChanged._;
  factory AuthEvent.signUpTap() = SignUpTap._;
}

final class EmailChanged implements AuthEvent {
  EmailChanged._(this.email);

  final String email;
}

final class PasswordChanged implements AuthEvent {
  PasswordChanged._(this.password);

  final String password;
}

final class SignUpTap implements AuthEvent {
  SignUpTap._();
}
