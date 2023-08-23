import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class AuthServiceButton extends StatelessWidget {
  AuthServiceButton({
    super.key,
    required double height,
    required double width,
    required this.icon,
    this.onClick,
  })  : _height = height,
        _width = width;

  final double _height;
  final double _width;
  final IconData icon;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick!(),
      child: Container(
        height: _height * 7,
        width: _width * 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Pellet.kDark,
        ),
        child: Icon(
          icon,
          color: Pellet.kWhite,
          size: 30,
        ),
      ),
    );
  }
}
