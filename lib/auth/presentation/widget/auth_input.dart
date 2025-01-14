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
    required this.isValid,
  });

  final String hint;
  final bool isValid;
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
        color: widget.isValid ? AppColors.darkStateBlue : AppColors.borderError,
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
          color: widget.isValid ? AppColors.blueGrey : AppColors.borderError,
        ),
        hintText: widget.hint,
        fillColor: widget.isValid ? AppColors.white : AppColors.backgroundError,
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
            color: widget.isValid
                ? AppColors.darkBlueAlpha20
                : AppColors.borderError,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            color: widget.isValid ? AppColors.blueGrey : AppColors.borderError,
            width: 1.0, // Making focused border slightly thicker
          ),
        ),
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                iconSize: 20.0,
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: widget.isValid
                      ? AppColors.blueGrey
                      : AppColors.borderError,
                ),
                onPressed: () => setState(() => isObscured = !isObscured),
              )
            : null,
      ),
    );
  }
}
