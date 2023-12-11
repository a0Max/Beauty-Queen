// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class DotsIndicator extends StatelessWidget {
//   final int itemCount;
//   final int currentIndex;
//   final PageController pageController;
//
//   const DotsIndicator({
//     super.key,
//     required this.itemCount,
//     required this.currentIndex,
//     required this.pageController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(itemCount, (index) {
//         return Container(
//           width: 8.0,
//           height: 8.0,
//           margin: EdgeInsets.symmetric(horizontal: 4.w),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: index == currentIndex ? Colors.blue : Colors.grey,
//           ),
//         );
//       }),
//     );
//   }
// }
