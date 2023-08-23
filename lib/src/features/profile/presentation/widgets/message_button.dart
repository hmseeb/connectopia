import 'package:flutter/material.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class ProfileMessageButton extends StatelessWidget {
  const ProfileMessageButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _width * 10,
          vertical: _height * 1,
        ),
        decoration: BoxDecoration(
          gradient: Pellet.kFlashBackgroundGradient,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
