import "package:auth_form/auth/domain/validation/email_error.dart";

class EmailValidator {
  static final _regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

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
