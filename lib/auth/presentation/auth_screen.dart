import "package:auth_form/auth/domain/validation/email_error.dart";
import "package:auth_form/auth/domain/validation/password_error.dart";
import "package:auth_form/auth/presentation/auth_bloc.dart";
import "package:auth_form/auth/presentation/contract/auth_event.dart";
import "package:auth_form/auth/presentation/contract/auth_state.dart";
import "package:auth_form/auth/presentation/widget/auth_button.dart";
import "package:auth_form/auth/presentation/widget/auth_input.dart";
import "package:auth_form/auth/presentation/widget/background.dart";
import "package:auth_form/auth/presentation/widget/validations_list.dart";
import "package:auth_form/theme/app_colors.dart";
import "package:auth_form/theme/app_fonts.dart";
import "package:auth_form/theme/app_strings.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          BlocProvider(
            create: (_) => AuthBloc(),
            child: const AuthContent(),
          ),
        ],
      ),
    );
  }
}

class AuthContent extends StatelessWidget {
  const AuthContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 32.0),
            child: Text(
              AppStrings.authTitle,
              style: TextStyle(
                color: AppColors.darkStateBlue,
                fontFamily: AppFonts.inter,
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 30.0,
            ),
            child: AuthInput(
              hint: AppStrings.emailHint,
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthEvent.emailChanged(value)),
              value: state.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              isValid: state.isEmailValid,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            width: double.infinity,
            child: ValidationsList(
              validations: state.emailValidationStatus.map(
                (key, value) => MapEntry(emailErrorText(key), value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 30.0,
            ),
            child: AuthInput(
              hint: AppStrings.passwordHint,
              onChanged: (value) => context
                  .read<AuthBloc>()
                  .add(AuthEvent.passwordChanged(value)),
              value: state.password,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              isValid: state.isPasswordValid,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            width: double.infinity,
            child: ValidationsList(
              validations: state.passwordValidationStatus.map(
                (key, value) => MapEntry(passwordErrorText(key), value),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: SizedBox(
              width: 240.0,
              child: AuthButton(
                text: AppStrings.signUpButton,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<AuthBloc>().add(AuthEvent.signUpTap());
                },
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  String emailErrorText(EmailError error) => switch (error) {
        EmailError.wrongPattern => AppStrings.emailPatternError,
        EmailError.empty => AppStrings.emailEmptyError,
      };

  String passwordErrorText(PasswordError error) => switch (error) {
        PasswordError.tooShort => AppStrings.passwordMinLengthHint,
        PasswordError.noUpperLowerCase => AppStrings.passwordCaseHint,
        PasswordError.noDigits => AppStrings.passwordDigitHint,
      };
}
