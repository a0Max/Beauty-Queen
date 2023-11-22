// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';

class TextFieldWithDropdown extends StatelessWidget {
  final String hintText;
  final List<String> dropdownItems;
  final String selectedDropdownValue;
  final ValueChanged<String?> onDropdownChanged;
  final ValueChanged<String> onTextChanged;
  final double? height;
  final double? width;

  const TextFieldWithDropdown({
    super.key,
    required this.hintText,
    required this.dropdownItems,
    required this.selectedDropdownValue,
    required this.onDropdownChanged,
    required this.onTextChanged,
    this.height = 64.35,
    this.width = 398,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          border: Border.all(width: 1.w, color: kTextGrayColor)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
              onChanged: onTextChanged,
            ),
          ),
          SizedBox(width: 10.w), // Add spacing between text field and dropdown
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: DropdownButton<String>(
              icon: Icon(
                Icons.keyboard_arrow_down,
                size: 30.r,
                color: kBlackColor,
              ),
              value:
                  selectedDropdownValue.isEmpty ? null : selectedDropdownValue,
              items: dropdownItems.map((String? item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item!),
                );
              }).toList(),
              onChanged: onDropdownChanged,
            ),
          ),
        ],
      ),
    );
  }
}
