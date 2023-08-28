import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PageTitleView extends StatelessWidget {
  const PageTitleView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Notifications',
          style: TextStyle(
            fontSize: _width * ScreenSize.kSpaceXL,
            fontWeight: FontWeight.bold,
            color: Pellet.kWhite,
          ),
        ),
        Text(
          'Mark Read',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Pellet.kBlue,
          ),
        ),
      ],
    );
  }
}
