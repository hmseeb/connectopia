import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sizing.dart';

class TitleBadge extends StatelessWidget {
  const TitleBadge({
    super.key,
    required this.username,
    required this.isVerified,
    required this.name,
  });

  final String username;
  final String name;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (name.isEmpty)
          Text(
            username,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        else ...[
          Column(
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@$username',
                style: TextStyle(color: Pellete.kGrey),
              ),
            ],
          ),
        ],

        // Add logic if email account is verified add this badge
        if (isVerified) SizedBox(width: _width * 2),
        if (isVerified) Icon(Icons.verified, color: Colors.blue),
      ],
    );
  }
}
