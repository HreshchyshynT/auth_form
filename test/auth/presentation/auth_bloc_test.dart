import "package:auth_form/auth/domain/validation/email_error.dart";
import "package:auth_form/auth/domain/validation/password_error.dart";
import "package:auth_form/auth/presentation/auth_bloc.dart";
import "package:auth_form/auth/presentation/contract/auth_event.dart";
import "package:auth_form/auth/presentation/model/validation_status.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AuthBloc", () {
    late AuthBloc bloc;

    setUp(() {
      bloc = AuthBloc();
    });

    test("no email errors emitted when user types email", () async {
      const email = "not_completed_email";
      bloc.add(AuthEvent.emailChanged(email));
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, isEmpty);
    });

    test(
        "password error statuses are none if rules are not met when user types passwod",
        () async {
      const password = "short";
      bloc.add(AuthEvent.passwordChanged(password));
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.none,
        PasswordError.noUpperLowerCase: ValidationStatus.none,
        PasswordError.noDigits: ValidationStatus.none,
      });
    });

    test(
        "email and password errors are emitted properly when user taps sign up button, empty input",
        () async {
      bloc.add(AuthEvent.signUpTap());
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, {
        EmailError.empty: ValidationStatus.invalid,
      });
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.invalid,
        PasswordError.noUpperLowerCase: ValidationStatus.invalid,
        PasswordError.noDigits: ValidationStatus.invalid,
      });
    });

    test(
        "email and password errors are emitted properly when user taps sign up button",
        () async {
      bloc.add(AuthEvent.emailChanged("not_completed_email"));
      bloc.add(AuthEvent.passwordChanged("Sh0rt"));
      bloc.add(AuthEvent.signUpTap());
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, {
        EmailError.wrongPattern: ValidationStatus.invalid,
      });
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.invalid,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
    });

    test(
        "email and password errors are emitted properly when user taps sign up button",
        () async {
      bloc.add(AuthEvent.emailChanged("valid@gmail.com"));
      bloc.add(AuthEvent.passwordChanged("Valid123"));
      bloc.add(AuthEvent.signUpTap());
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, isEmpty);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.valid,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
    });

    test("email errors are cleared after email is changed", () async {
      bloc.add(AuthEvent.emailChanged("not_completed_email"));
      bloc.add(AuthEvent.signUpTap());
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, {
        EmailError.wrongPattern: ValidationStatus.invalid,
      });
      bloc.add(AuthEvent.emailChanged("not_completed_emai"));
      await Future.delayed(Duration.zero);
      expect(bloc.state.emailValidationStatus, isEmpty);
    });

    test("password errors are cleared after password is changed", () async {
      bloc.add(AuthEvent.passwordChanged("Sh0rt"));
      bloc.add(AuthEvent.signUpTap());
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.invalid,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
      bloc.add(AuthEvent.passwordChanged("Sh0rt"));
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.none,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
    });

    test("password errors become valid when password changes", () async {
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.none,
        PasswordError.noUpperLowerCase: ValidationStatus.none,
        PasswordError.noDigits: ValidationStatus.none,
      });
      bloc.add(AuthEvent.passwordChanged("Sh"));
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.none,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.none,
      });
      bloc.add(AuthEvent.passwordChanged("Sh0"));
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.none,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
      bloc.add(AuthEvent.passwordChanged("Sh0rtNOT"));
      await Future.delayed(Duration.zero);
      expect(bloc.state.passwordValidationStatus, {
        PasswordError.tooShort: ValidationStatus.valid,
        PasswordError.noUpperLowerCase: ValidationStatus.valid,
        PasswordError.noDigits: ValidationStatus.valid,
      });
    });
  });
}
