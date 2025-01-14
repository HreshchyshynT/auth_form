import "package:auth_form/auth/presentation/model/validation_status.dart";
import "package:auth_form/theme/app_colors.dart";
import "package:auth_form/theme/app_fonts.dart";
import "package:flutter/material.dart";

class AuthInput extends StatefulWidget {
  const AuthInput({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.value,
    required this.keyboardType,
    required this.textInputAction,
    required this.validationStatus,
  });

  final String hint;
  final ValidationStatus validationStatus;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final String value;
  final TextInputAction textInputAction;

  static const borderRadius = BorderRadius.all(Radius.circular(10.0));

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  late bool isObscured = widget.keyboardType == TextInputType.visiblePassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      obscureText: isObscured,
      textInputAction: widget.textInputAction,
      style: TextStyle(
        fontFamily: AppFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        color: switch (widget.validationStatus) {
          ValidationStatus.invalid => AppColors.borderError,
          ValidationStatus.valid => AppColors.green,
          ValidationStatus.none => AppColors.darkStateBlue,
        },
      ),
      decoration: InputDecoration(
        hoverColor: AppColors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        hintStyle: TextStyle(
          fontFamily: AppFonts.inter,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: switch (widget.validationStatus) {
            ValidationStatus.invalid => AppColors.borderError,
            ValidationStatus.valid => AppColors.green,
            ValidationStatus.none => AppColors.blueGrey,
          },
        ),
        hintText: widget.hint,
        fillColor: widget.validationStatus.isInvalid
            ? AppColors.backgroundError
            : AppColors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            color: AppColors.darkBlueAlpha20,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            // todo: add is validation check
            color: switch (widget.validationStatus) {
              ValidationStatus.invalid => AppColors.borderError,
              ValidationStatus.valid => AppColors.green,
              ValidationStatus.none => AppColors.darkBlueAlpha20,
            },
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            color: switch (widget.validationStatus) {
              ValidationStatus.invalid => AppColors.borderError,
              ValidationStatus.valid => AppColors.green,
              ValidationStatus.none => AppColors.blueGrey,
            },
            width: 1.0, // Making focused border slightly thicker
          ),
        ),
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                iconSize: 20.0,
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: switch (widget.validationStatus) {
                    ValidationStatus.invalid => AppColors.borderError,
                    ValidationStatus.valid => AppColors.green,
                    ValidationStatus.none => AppColors.blueGrey,
                  },
                ),
                onPressed: () => setState(() => isObscured = !isObscured),
              )
            : null,
      ),
    );
  }
}
