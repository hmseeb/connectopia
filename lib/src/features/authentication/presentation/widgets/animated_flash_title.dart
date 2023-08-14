import 'package:flutter/material.dart';

class AnimatedFlashTitle extends StatelessWidget {
  const AnimatedFlashTitle({
    super.key,
    required int opacity,
    required this.title,
  }) : _opacity = opacity;

  final int _opacity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity.toDouble(),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeInOut,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
