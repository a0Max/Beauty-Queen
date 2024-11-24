import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.kLightGreyBlueColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double dashWidth = 10.0;
    double dashSpace = 5.0;

    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0.0),
        Offset(startX + dashWidth, 0.0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
