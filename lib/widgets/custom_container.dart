// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomContainer extends StatelessWidget {
//   final double height;
//   final double width;
//   final Color backgroundColor;
//   final String text;
//   final String? imagePath;
//
//   final TextStyle? textStyle;
//
//   const CustomContainer({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.backgroundColor,
//     required this.text,
//     this.imagePath,
//     this.textStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       color: backgroundColor,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(width: 35.w),
//           imagePath != null
//               ? Image.asset(
//                   imagePath!) // Display image if imagePath is not null
//               : const SizedBox(),
//           SizedBox(width: 13.w), // Adjust the spacing as needed
//           Text(text, style: textStyle),
//         ],
//       ),
//     );
//   }
// }
