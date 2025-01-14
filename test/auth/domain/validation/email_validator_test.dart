// tests for email_validator.dart
import "package:auth_form/auth/domain/validation/email_error.dart";
import "package:auth_form/auth/domain/validation/email_validator.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("EmailValidator", () {
    final validator = EmailValidator();

    test("should return EmailError.empty when email is empty", () {
      final result = validator.validate("");
      expect(result, EmailError.empty);
    });

    test("should return EmailError.wrongPattern when email is in wrong pattern",
        () {
      for (final email in [
        "email",
        "email@",
        "email@domain",
        "email@domain.",
        "email_domain.com",
      ]) {
        final result = validator.validate(email);
        expect(result, EmailError.wrongPattern, reason: "email: $email");
      }
    });

    test("should return null when email is valid", () {
      final result = validator.validate("valid.email@gmail.com");
      expect(result, isNull);
    });
  });
}
