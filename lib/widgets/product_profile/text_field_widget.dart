import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? titleText;
  final TextEditingController? controler;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final bool? obscureText;
  final String? oldData;
  final int? maxLinesInt;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  final TextAlign? textAlign;
  final bool? isItOptional;
  final bool? autoFoucs;
  final double? height;
  final double? borderRadius;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator? validatorTextField;
  final Color? borderColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  const TextFieldWidget(
      {super.key,
      this.rightWidget,
      this.obscureText,
      this.oldData,
      this.borderRadius,
      this.inputFormatters,
      this.onFieldSubmitted,
      this.titleText,
      this.autoFoucs,
      this.height,
      this.maxLinesInt,
      this.leftWidget,
      this.textAlign,
      this.isItOptional,
      this.onChanged,
      this.maxLength,
      this.onTap,
      this.keyboardType,
      this.borderColor,
      this.hintText,
      this.controler,
      this.validatorTextField});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
          child: TextFormField(
              controller: controler,
              autofocus: autoFoucs ?? false,
              keyboardType: keyboardType,
              onFieldSubmitted: onFieldSubmitted,
              initialValue: oldData,
              validator: validatorTextField,
              onTap: onTap,
              inputFormatters: inputFormatters,
              maxLines: maxLinesInt,
              maxLength: maxLength,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColors.mainColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                    borderSide:
                        BorderSide(color: borderColor ?? AppColors.greyColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                    borderSide: const BorderSide(color: AppColors.redColor),
                  ),
                  suffixIcon: rightWidget,
                  filled: true,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                    borderSide: const BorderSide(color: AppColors.redColor),
                  ),
                  prefixIcon: leftWidget,
                  counterText: '',
                  fillColor: Colors.white,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14)),
              onChanged: onChanged,
              textAlign: textAlign ?? TextAlign.start,
              obscureText: obscureText ?? false),
        ),
      ],
    );
  }
}
