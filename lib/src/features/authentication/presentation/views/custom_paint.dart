import '../../../../theme/colors.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromARGB(255, 27, 27, 28)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.0020000);
    path_0.lineTo(size.width * 0.1000000, size.height * 0.2040000);
    path_0.lineTo(size.width * 0.0500000, size.height * 0.7980000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9980000);
    path_0.lineTo(size.width * 0.9480000, size.height * 0.8000000);
    path_0.lineTo(size.width * 0.9010000, size.height * 0.1940000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.0020000);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = Pellete.kPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
