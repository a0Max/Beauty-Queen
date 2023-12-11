// // ignore_for_file: file_names
//
// import 'package:beauty_queen/const/colors.dart';
// import 'package:beauty_queen/const/styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../controller/FilterController.dart';
//
// class CustomFilterChip extends StatelessWidget {
//   final String label;
//   final IconData? icon;
//   final Color selectedBackgroundColor;
//   final double borderRadius;
//   final FilterController filterController; // Receive the controller instance
//
//   const CustomFilterChip({
//     super.key,
//     // Use Key instead of super.key
//     required this.label,
//     this.icon,
//     this.selectedBackgroundColor = kGrayColor,
//     this.borderRadius = 50.0,
//     required this.filterController, // Receive the controller instance
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final isSelected = filterController.isChipSelected(label);
//       // Use the passed controller instance
//       final shape = RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(borderRadius),
//       );
//       return SizedBox(
//         height: 34.95.h,
//         width: 92.12.w,
//         child: ChoiceChip(
//           elevation: 0,
//           selected: isSelected,
//           onSelected: (bool selected) {
//             filterController
//                 .toggleChip(label); // Use the passed controller instance
//           },
//           label: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               if (icon != null)
//                 Icon(icon, color: isSelected ? kWhiteColor : kGrayColor),
//               Text(
//                 label,
//                 style: TextStyle(
//                     color: isSelected ? kWhiteColor : kGrayColor,
//                     fontFamily: kTheArabicSansLight,
//                     fontSize: 10.14.sp,
//                     fontWeight: FontWeight.w700),
//               ),
//             ],
//           ),
//           selectedColor: kPrimaryColor,
//           shape: shape,
//           showCheckmark: false,
//         ),
//       );
//     });
//   }
// }
