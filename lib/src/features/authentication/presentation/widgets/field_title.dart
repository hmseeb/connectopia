import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

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
      style: TextStyle(color: Pellet.kWhite, fontWeight: FontWeight.bold),
    );
  }
}
