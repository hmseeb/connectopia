// responsive spacing constants
import 'package:flutter/material.dart';

class ScreenSize {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width / 100;
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height / 100;
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static double kSpaceXS = 0.5;
  static double kSpaceS = 1;
  static double kSpaceM = 2;
  static double kSpaceL = 3;
  static double kSpaceXL = 4;
  static double kSpaceXXL = 5;
}
