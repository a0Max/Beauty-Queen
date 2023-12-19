import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    double dashWidth = 5.0;
    double dashSpace = 3.0;

    // Draw top border
    double startY = 0.0;
    while (startY < size.width) {
      canvas.drawLine(
          Offset(startY, 0.0), Offset(startY + dashWidth, 0.0), paint);
      startY += dashWidth + dashSpace;
    }

    // Draw right border
    double startX = size.width - dashWidth;
    while (startX > 0.0) {
      canvas.drawLine(Offset(size.width, startX),
          Offset(size.width, startX - dashWidth), paint);
      startX -= dashWidth + dashSpace;
    }

    // Draw bottom border
    startY = size.height - dashWidth;
    while (startY > 0.0) {
      canvas.drawLine(Offset(startY, size.height),
          Offset(startY - dashWidth, size.height), paint);
      startY -= dashWidth + dashSpace;
    }

    // Draw left border
    startX = 0.0;
    while (startX < size.height) {
      canvas.drawLine(
          Offset(0.0, startX), Offset(0.0, startX + dashWidth), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ImageWithTextOverlay extends StatelessWidget {
  final String text1;
  final String text2;

  const ImageWithTextOverlay({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.mainColor,
      strokeWidth: 1,
      dashPattern: const <double>[3, 5],
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
