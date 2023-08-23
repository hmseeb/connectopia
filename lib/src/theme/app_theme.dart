import 'package:flutter/material.dart';

import 'buttons.dart';
import 'colors.dart';

ThemeData connectopiaThemeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Pellet.kWhite,
          displayColor: Pellet.kWhite,
        ),
    scaffoldBackgroundColor: Colors.transparent,
    elevatedButtonTheme: CustomElevetedButton.elevetedButtonThemeData(),
    fontFamily: 'Heebo',
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Pellet.kPrimary,
      secondary: Pellet.kSecondary,
    ),
  );
}
