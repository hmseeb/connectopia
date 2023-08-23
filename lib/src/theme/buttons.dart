import 'package:flutter/material.dart';

import 'colors.dart';

class CustomElevetedButton {
  static ElevatedButtonThemeData elevetedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Pellet.kWhite,
        backgroundColor: Pellet.kPrimary,
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
