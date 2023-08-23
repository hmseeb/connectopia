import 'package:flutter/cupertino.dart';

import '../../../../theme/colors.dart';

class SheetTitle extends StatelessWidget {
  const SheetTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      decoration: BoxDecoration(
        color: Pellet.kWhite.withOpacity(0.5),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
