import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class PinkTicket extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9942252, size.height * 0.02098474);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.02098474);
    path_0.lineTo(size.width * 0.04003027, size.height * 0.1168458);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.2127067);
    path_0.lineTo(size.width * 0.04003027, size.height * 0.3085674);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.4044279);
    path_0.lineTo(size.width * 0.04003027, size.height * 0.5002907);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.5961512);
    path_0.lineTo(size.width * 0.04003027, size.height * 0.6920116);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.7878721);
    path_0.lineTo(size.width * 0.04003027, size.height * 0.8837326);
    path_0.lineTo(size.width * 0.002599766, size.height * 0.9795953);
    path_0.lineTo(size.width * 0.9942252, size.height * 0.9795953);
    path_0.lineTo(size.width * 0.9942252, size.height * 0.02098474);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffF4C6DD).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
