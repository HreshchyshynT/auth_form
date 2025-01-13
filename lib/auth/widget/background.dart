import "dart:math";

import "package:auth_form/theme/app_icons.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF2F8FF),
            Color(0xFFE2EEFC),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: screenWidth * 0.78,
            top: screenHeight * 0.09,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.55),
              child: SvgPicture.asset(
                AppIcons.star,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.38,
            top: screenHeight * 0.19,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.75),
              child: SvgPicture.asset(
                AppIcons.star,
                width: 28.0,
                height: 28.0,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.25,
            top: screenHeight * 0.22,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.8),
              child: SvgPicture.asset(
                AppIcons.star,
                width: 28.0,
                height: 28.0,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.65,
            top: screenHeight * 0.38,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.99),
              child: SvgPicture.asset(
                AppIcons.star,
                width: 28.0,
                height: 28.0,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.28,
            top: screenHeight * 0.65,
            child: SvgPicture.asset(
              AppIcons.star,
              width: 28.0,
              height: 28.0,
            ),
          ),
          Positioned(
            left: screenWidth * 0.78,
            top: screenHeight * 0.68,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.8),
              child: SvgPicture.asset(
                AppIcons.star,
                width: 28.0,
                height: 28.0,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.18,
            top: screenHeight * 0.92,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(0.8),
              child: SvgPicture.asset(
                AppIcons.star,
                width: 28.0,
                height: 28.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
