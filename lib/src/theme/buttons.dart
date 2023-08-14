import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomElevetedButton {
  static ElevatedButtonThemeData elevetedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Pellete.kWhite,
        backgroundColor: Pellete.kPrimary,
        textStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
        fixedSize: const Size(
          400,
          60,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
