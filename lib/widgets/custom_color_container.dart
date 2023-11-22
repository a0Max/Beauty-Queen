import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final VoidCallback? onClick;

  const ColorContainer({
    super.key,
    this.height,
    this.width,
    this.color,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}
