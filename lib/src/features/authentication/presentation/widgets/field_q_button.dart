import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';

class TextFieldQButton extends StatelessWidget {
  const TextFieldQButton({
    super.key,
    required this.title,
    this.onTapped,
  });
  final Function()? onTapped;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Text(
        title,
        style:
            TextStyle(color: Pellete.kSecondary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
