import "package:auth_form/auth/auth_bloc.dart";
import "package:auth_form/auth/contract/auth_event.dart";
import "package:auth_form/auth/widget/auth_button.dart";
import "package:auth_form/auth/widget/auth_input.dart";
import "package:auth_form/auth/widget/background.dart";
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
    final bloc = context.read<AuthBloc>();
    return Column(
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
            onChanged: (value) => bloc.add(AuthEvent.emailChanged(value)),
            value: "",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 30.0,
          ),
          child: AuthInput(
            hint: AppStrings.passwordHint,
            onChanged: (value) => bloc.add(AuthEvent.passwordChanged(value)),
            value: "",
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: SizedBox(
            width: 240.0,
            child: AuthButton(
              text: AppStrings.signUpButton,
              onTap: () {},
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
