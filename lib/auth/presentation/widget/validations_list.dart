import "package:auth_form/auth/presentation/model/validation_status.dart";
import "package:auth_form/theme/app_colors.dart";
import "package:auth_form/theme/app_fonts.dart";
import "package:flutter/widgets.dart";

class ValidationsList extends StatelessWidget {
  const ValidationsList({
    super.key,
    required this.validations,
  });

  final Map<String, ValidationStatus> validations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in validations.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: _ValidationText(
              text: entry.key,
              status: entry.value,
            ),
          ),
      ],
    );
  }
}

class _ValidationText extends StatelessWidget {
  const _ValidationText({
    required this.text,
    required this.status,
  });
  final String text;
  final ValidationStatus status;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontFamily: AppFonts.inter,
        fontWeight: FontWeight.w400,
        fontSize: 13.0,
        color: switch (status) {
          ValidationStatus.valid => AppColors.greenAlpha70,
          ValidationStatus.invalid => AppColors.borderError,
          ValidationStatus.none => AppColors.darkStateBlue,
        },
      ),
    );
  }
}
