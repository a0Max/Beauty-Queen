import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../order/rps_custom_painter.dart';

class ShimmerTicket extends StatelessWidget {
  const ShimmerTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            SizedBox(
              height: 33.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomPaint(
                size: Size(
                    MediaQuery.of(context).size.width,
                    (MediaQuery.of(context).size.width * 1.3283208020050126)
                        .toDouble()),
                painter: RPSCustomPainter(),
              ),
            ),
          ],
        ));
  }
}
