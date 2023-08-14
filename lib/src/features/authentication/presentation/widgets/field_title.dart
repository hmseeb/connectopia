import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Pellete.kWhite, fontWeight: FontWeight.bold),
    );
  }
}
