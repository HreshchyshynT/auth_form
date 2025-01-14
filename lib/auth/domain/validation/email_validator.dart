import "package:auth_form/auth/domain/validation/email_error.dart";

class EmailValidator {
  static final _regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  EmailError? validate(String email) {
    if (email.isEmpty) {
      return EmailError.empty;
    } else if (!_regExp.hasMatch(email)) {
      return EmailError.wrongPattern;
    } else {
      return null;
    }
  }
}
