import "package:equatable/equatable.dart";

final class AuthState extends Equatable {
  const AuthState({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  static const initial = AuthState(email: "", password: "");

  AuthState copyWith({
    String? email,
    String? password,
  }) =>
      AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object?> get props => [email, password];
}
