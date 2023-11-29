// // ignore_for_file: file_names
//
// import 'package:beauty_queen/const/colors.dart';
// import 'package:beauty_queen/const/styles.dart';
// import 'package:beauty_queen/controller/auth_controller/signUpcontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class CustomTextField extends StatelessWidget {
//   final String hintText;
//   final bool initialObscureText;
//   final TextInputType keyboardType;
//   final IconData? suffixIcon;
//   final CombinedController controller;
//   final RxBool obscureTextObservable;
//
//   const CustomTextField({
//     super.key,
//     required this.hintText,
//     this.initialObscureText = false,
//     this.keyboardType = TextInputType.text,
//     this.suffixIcon,
//     required this.controller,
//     required this.obscureTextObservable,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CombinedController>(
//       init: controller,
//       builder: (controller) {
//         return Obx(() {
//           return SizedBox(
//             height: 63.62.h,
//             width: 399.59.w,
//             child: TextField(
//               keyboardType: keyboardType,
//               obscureText: obscureTextObservable.value,
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 hintStyle: TextStyle(
//                   color: const Color(0xFF2C3E50),
//                   fontSize: 17.69.sp,
//                   fontFamily: kTheArabicSansLight,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 15.0.w),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(11.06.r),
//                   borderSide:
//                       BorderSide(width: 1.12.w, color: const Color(0xFFD9DEE2)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(11.06.r),
//                   borderSide:
//                       BorderSide(width: 1.12.w, color: const Color(0xFFD9DEE2)),
//                 ),
//                 suffixIcon: suffixIcon != null
//                     ? IconButton(
//                         icon: Icon(
//                           suffixIcon,
//                           color: kTextGrayColor,
//                           size: 25,
//                         ),
//                         onPressed: () {
//                           if (obscureTextObservable ==
//                               controller.passwordObscureText) {
//                             controller.togglePasswordVisibility();
//                           } else if (obscureTextObservable ==
//                               controller.confirmPasswordObscureText) {
//                             controller.toggleConfirmPasswordVisibility();
//                           }
//                         },
//                       )
//                     : null,
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
