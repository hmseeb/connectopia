import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'colors.dart';

class PinputTheme {
  static final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Pellet.kSecondary),
    borderRadius: BorderRadius.circular(8),
  );

  static final submittedPinTheme = defaultPinTheme.copyWith(
    textStyle: defaultPinTheme.textStyle!.copyWith(
      color: Pellet.kWhite,
    ),
    decoration: defaultPinTheme.decoration!.copyWith(
      color: Pellet.kPrimary,
    ),
  );

  static final errorPinTheme = defaultPinTheme.copyWith(
    textStyle: defaultPinTheme.textStyle!.copyWith(
      color: Colors.redAccent,
    ),
    decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: Colors.redAccent),
    ),
  );
}
