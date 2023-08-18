import 'package:flutter/material.dart';

class Pellete {
  static const Color kPrimary = Color(0xFFF22CAC);
  static const Color kSecondary = Color(0xFF53ABFF);
  static const Color kTertiary = Color(0xFFACDF3A);
  static const Color kWhite = Color(0xFFf5f5f7);
  static const Color kBlack = Color.fromARGB(255, 27, 27, 28);
  static Color kGrey = kWhite.withOpacity(0.5);
  static const Color kBlue = Colors.blueAccent;
  static const Gradient kBackgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xff2f0f28),
      Color(0xff0c1427),
    ],
  );
  static const Gradient kFlashBackgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xffbc5eff),
      Color(0xff4385f8),
    ],
  );
}
