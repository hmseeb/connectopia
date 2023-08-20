import 'package:connectopia/src/constants/sizing.dart';
import 'package:flutter/material.dart';

class TitleBadge extends StatelessWidget {
  const TitleBadge({
    super.key,
    required this.username,
    required this.isVerified,
  });

  final String username;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          username,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Add logic if email account is verified add this badge
        if (isVerified) SizedBox(width: _width * 2),
        if (isVerified) Icon(Icons.verified, color: Colors.blue),
      ],
    );
  }
}
