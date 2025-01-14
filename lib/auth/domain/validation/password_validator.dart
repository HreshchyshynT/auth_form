// password validator which checks if the password fit the following rules:
// 1. The password must be at least 8 characters long (no spaces)
// 2. uppercase and lowercase letters
// 3. at least one digit
// validatate method should return List<PasswordError>? which will contain
// error for each rule that is not met. If the password is valid, the method
// should return null.
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
