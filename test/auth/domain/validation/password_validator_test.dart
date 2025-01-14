import "package:flutter_test/flutter_test.dart";
import "package:auth_form/auth/domain/validation/password_error.dart";
import "package:auth_form/auth/domain/validation/password_validator.dart";

void main() {
  group("PasswordValidator", () {
    final validator = PasswordValidator();

    test("returns null for a valid password", () {
      const password = "Valid123";
      final result = validator.validate(password);
      expect(result, isNull);
    });

    group("length and space validation", () {
      test("returns tooShort for passwords shorter than 8 characters", () {
        const password = "Short1";
        final result = validator.validate(password);
        expect(result, contains(PasswordError.tooShort));
        expect(result?.length, 1);
      });

      test("returns tooShort for passwords containing spaces", () {
        const password = "Pass word1";
        final result = validator.validate(password);
        expect(result, contains(PasswordError.tooShort));
        expect(result?.length, 1);
      });

      test("returns tooShort for passwords with only spaces", () {
        const password = "        ";
        final result = validator.validate(password);
        expect(result, contains(PasswordError.tooShort));
      });

      test("returns tooShort for passwords with leading/trailing spaces", () {
        const password = " Password1 ";
        final result = validator.validate(password);
        expect(result, contains(PasswordError.tooShort));
      });
    });

    test("returns noUpperLowerCase for passwords without mixed case letters",
        () {
      const password = "lowercase1";
      final result = validator.validate(password);
      expect(result, contains(PasswordError.noUpperLowerCase));
      expect(result?.length, 1);
    });

    test("returns noDigits for passwords without digits", () {
      const password = "NoDigits!";
      final result = validator.validate(password);
      expect(result, contains(PasswordError.noDigits));
      expect(result?.length, 1);
    });

    test(
        "returns all errors for passwords that are too short, lack mixed case letters, and lack digits",
        () {
      const password = "short";
      final result = validator.validate(password);
      expect(
        result,
        containsAll({
          PasswordError.tooShort,
          PasswordError.noUpperLowerCase,
          PasswordError.noDigits,
        }),
      );
      expect(result?.length, 3);
    });

    test(
        "returns no errors for passwords with exactly 8 characters that meet all rules",
        () {
      const password = "Valid123";
      final result = validator.validate(password);
      expect(result, isNull);
    });
  });
}
