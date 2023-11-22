import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final double width;
  final double height;
  final double borderRadius;
  final Function onPressed;
  final TextStyle textStyle;
  final BoxBorder? border;

  const CustomButton({
    super.key,
    required this.text,
    this.border,
    required this.backgroundColor,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.onPressed,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
