import 'dart:developer';

import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/images.dart';
import '../../const/styles.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/CustomAlertBox.dart';
import '../../widgets/CustomCardWidget.dart';
import '../../widgets/product_profile/rating_widget.dart';

class TabScreenTwo extends StatelessWidget {
  TabScreenTwo({super.key});
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductProfileController controller =
    Get.put(ProductProfileController());

    // final RxInt currentRating = 0.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        TextField(
          maxLines: 5, // Set the maximum lines to 5
          controller: commentController,
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w)),
              hintText: 'أكتب تقييماً...',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor, width: 2.w))),
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                controller.getImage();
              },
              child: Text(
                'إضافة صورة',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    decorationColor: kPrimaryColor,
                    decoration: TextDecoration.underline,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            RatingWidget(maxRating: 5),
          ],
        ),
        SizedBox(
          height: 42.w,
        ),
        GestureDetector(
          onTap: () async {
            LoadingScreen.show(context);
            await controller.verifyToAddReview(comment: commentController.text);
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                    buttonTwo: false,
                    height: 172.29.h,
                    width: 339.97.w,
                    dilougText:
                        'تم ارسال تقييمك بنجاح. سيتم نشره حال موافقة مسؤولين المتجر عليه',
                    buttonOneText: 'حسناً',
                  );
                });
          },
          child: Container(
            height: 37.83.h,
            width: 131.w,
            color: kPrimaryColor,
            child: Center(
              child: Text(
                'إرسال',
                style: TextStyle(
                    fontFamily: kTheArabicSansLight,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: kWhiteColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

