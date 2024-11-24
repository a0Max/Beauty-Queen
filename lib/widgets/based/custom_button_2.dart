import 'package:flutter/material.dart';

class CustomButtonTwo extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final String text;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const CustomButtonTwo({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.backgroundColor,
    required this.text,
    required this.onPressed,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
