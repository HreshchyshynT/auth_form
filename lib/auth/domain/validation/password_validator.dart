import "package:auth_form/auth/domain/validation/password_error.dart";

class PasswordValidator {
  static final _letterCaseRegExp = RegExp(r"(?=.*[A-Z])(?=.*[a-z])");
  static final _digitRegExp = RegExp(r"\d");
  static final _spaceRegExp = RegExp(r"\s");

  Set<PasswordError>? validate(String password) {
    final errors = <PasswordError>{};

    if (password.length < 8 || _spaceRegExp.hasMatch(password)) {
      errors.add(PasswordError.tooShort);
    }

    if (!_letterCaseRegExp.hasMatch(password)) {
      errors.add(PasswordError.noUpperLowerCase);
    }

    if (!_digitRegExp.hasMatch(password)) {
      errors.add(PasswordError.noDigits);
    }

    return errors.isEmpty ? null : errors;
  }
}
