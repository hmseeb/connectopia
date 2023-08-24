import 'package:flutter/material.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class OutlinedProfileButton extends StatelessWidget {
  const OutlinedProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.showOutline,
  });

  final String text;
  final Function() onPressed;
  final bool? showOutline;
  // Looked bad with default skeletonizer

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
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Pellet.kWhite,
            width: showOutline ?? true ? 1 : 0,
          ),
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class EditBannerButton extends StatelessWidget {
  const EditBannerButton({
    super.key,
    required this.text,
    required this.onPressed,
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
          horizontal: _width * 5,
          vertical: _height * 1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Pellet.kBlack.withOpacity(0.5),
          border: Border.all(color: Pellet.kWhite),
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
