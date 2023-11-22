import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback action;
  final Color backgroundColor;
  final double? paddingVertical;
  final Color textColor;
  final TextStyle? textStyle;
  final Widget? bodyWidget;
  final double? borderRadius;
  final double marginWidth;
  final double marginHeight;
  final Color boarderColor;

  const ButtonWidget(
      {Key? key,
      required this.textColor,
      required this.boarderColor,
      this.textStyle,
      required this.text,
        this.borderRadius,
      this.paddingVertical,
        this.bodyWidget,
      required this.marginHeight,
      required this.marginWidth,
      required this.action,
      required this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: marginWidth, vertical: marginHeight),
      padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: boarderColor,
          width: 1,
        ),
        borderRadius:  BorderRadius.all(
          Radius.circular(borderRadius??5.0),
        ),
      ),
      child: TextButton(
          onPressed: () {
            action();
          },
          child: bodyWidget??Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle ?? TextStyle(color: textColor, fontSize: 15),
            ),
          )),
    );
  }
}
