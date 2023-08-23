import 'package:flutter/material.dart';

import '../../constants/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(Assets.logo, height: height);
  }
}
