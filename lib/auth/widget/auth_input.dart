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
  });

  final String hint;
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
      style: const TextStyle(
        fontFamily: AppFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
        color: AppColors.darkStateBlue,
      ),
      decoration: InputDecoration(
        hoverColor: AppColors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        hintStyle: const TextStyle(
          fontFamily: AppFonts.inter,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: AppColors.blueGrey,
        ),
        hintText: widget.hint,
        fillColor: AppColors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            color: AppColors.darkBlueAlpha20,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            // todo: add is validation check
            color: true ? AppColors.darkBlueAlpha20 : AppColors.borderError,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AuthInput.borderRadius,
          borderSide: BorderSide(
            color: AppColors.blueGrey,
            width: 1.0, // Making focused border slightly thicker
          ),
        ),
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
                iconSize: 20.0,
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.blueGrey,
                ),
                onPressed: () => setState(() => isObscured = !isObscured),
              )
            : null,
      ),
    );
  }
}
