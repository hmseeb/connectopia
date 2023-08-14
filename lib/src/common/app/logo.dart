import 'package:connectopia/src/constants/assets.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.logo, height: height);
  }
}
