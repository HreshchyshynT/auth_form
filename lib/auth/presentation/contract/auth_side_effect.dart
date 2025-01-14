sealed class AuthSideEffect {
  factory AuthSideEffect.displayAuthSuccess() = DisplaySuccess._;
}

final class DisplaySuccess implements AuthSideEffect {
  DisplaySuccess._();
}
