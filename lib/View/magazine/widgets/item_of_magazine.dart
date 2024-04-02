import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';
import '../../../const/styles.dart';
import '../../../controller/home_controller/home_controller.dart';
import '../../../controller/nav_bar_controller/NavBarController.dart';
import '../../../models/magazines/magazines_model.dart';
import '../get_one_magazine_screen.dart';

class ItemOfMagazine extends StatelessWidget {
  final MagazinesModel data;

  const ItemOfMagazine({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 2) - 26,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                Connection.magazineVideoUrl + (data.magazineCover?.file ?? ''),
            height: 250,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 5,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                child: Text(
                  data.title ?? '',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 10.sp,
                    fontFamily: kTheArabicSansBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (data.isMagazinePurchasable == "0") {
                    return;
                  }
                  Get.to(GetOneMagazineScreen(
                    magazineId: "${data.id}",
                  ));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: data.isMagazinePurchasable == "0"
                        ? Colors.grey
                        : AppColors.kPrimaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'تصفحي الآن',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.kWhiteBlueColor,
                      fontSize: 10.sp,
                      fontFamily: kTheArabicSansBold,
                      fontWeight: FontWeight.w400,
                      // height: 0,
                    ),
                  ),
                ),
              )
            ],
          ),
          3.ph,
          GestureDetector(
            onTap: () async {
              if (data.isMagazinePurchasable == "0") {
                return;
              }
              final HomeController _controller = Get.put(HomeController());
              final NavController controller = Get.put(NavController());

              await _controller.addToCart(productId: data.id ?? 0);
              await controller.getCountOfCart();
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: data.isMagazinePurchasable == "0"
                      ? Colors.grey
                      : Colors.black),
              child: Text(
                'شراء نسخة مطبوعة',
                style: TextStyle(
                  color: AppColors.kWhiteBlueColor,
                  fontSize: 10.sp,
                  fontFamily: kTheArabicSansBold,
                  fontWeight: FontWeight.w400,
                  // height: 0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          3.ph,
          GestureDetector(
            onTap: () {
              if (data.isMagazinePurchasable == "0") {
                return;
              }
              Get.to(GetOneMagazineScreen(
                magazineId: "${data.id}",
              ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: data.isMagazinePurchasable == "0"
                      ? Colors.grey
                      : Colors.black),
              child: Text(
                'تصفح و تحميل ملف PDF',
                style: TextStyle(
                  color: AppColors.kWhiteBlueColor,
                  fontSize: 10.sp,
                  fontFamily: kTheArabicSansBold,
                  fontWeight: FontWeight.w400,
                  // height: 0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
