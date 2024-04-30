import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../const/app_colors.dart';

class ColorContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final int? selectedId;
  final int? currentId;
  final bool? inStock;
  final VoidCallback? onClick;

  const ColorContainer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.inStock,
    this.onClick,
    this.selectedId,
    this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                      color: selectedId == currentId
                          ? AppColors.mainColor
                          : Colors.transparent)),
              height: height,
              width: width,
            ),
            if (inStock == true) ...{
              SvgPicture.asset(
                AppImages.imageBlockItem,
                height: height,
                width: width,
              )
            }
          ],
        ),
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
  final bool? inStock;

  const TextContainer({
    super.key,
    this.height,
    this.width,
    this.text,
    this.onClick,
    this.inStock,
    this.selectedId,
    this.currentId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
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
          if (inStock == true) ...{
            SvgPicture.asset(
              AppImages.imageBlockItem,
              height: 50,
              width: 50,
            )
          }
        ],
      ),
    );
  }
}
