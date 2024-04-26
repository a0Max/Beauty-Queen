import 'package:beauty_queen/const/vars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/app_colors.dart';

class ColorContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final int? selectedId;
  final int? currentId;
  final VoidCallback? onClick;

  const ColorContainer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.onClick,
    this.selectedId,
    this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            border: Border.all(
                color: selectedId == currentId
                    ? AppColors.mainColor
                    : Colors.transparent)),
        height: height,
        width: width,
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final int? selectedId;
  final int? currentId;
  final VoidCallback? onClick;

  const TextContainer({
    super.key,
    this.height,
    this.width,
    this.text,
    this.onClick,
    this.selectedId,
    this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedId == currentId
                    ? AppColors.mainColor
                    : AppColors.kCDGColor2),
            borderRadius: BorderRadius.circular(5)),
        // height: height,
        // width: width,
        // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: CachedNetworkImage(
          imageUrl: Connection.urlOfOptions(image: text ?? ''),
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
