import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/categories/filter_screen.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../models/categories_model.dart';
import '../../models/user_model.dart';

class CustomImageList extends StatelessWidget {
  final List<CategoryModel> dataOfItem;
  // final List<String> texts;

  const CustomImageList({
    super.key,
    required this.dataOfItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dataOfItem.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            final AuthController _controllerLogin = Get.put(AuthController());
            UserModel user = _controllerLogin.userData.value;
            print('%%%%%%%%%:${user.id}');
            if (user.id == null) {
              _controllerLogin.alertOfLogin();
              return;
            }
            final AlkasamController controller = Get.put(AlkasamController());

            await controller.updateCurrentCategoryId(
                newId: dataOfItem[index].id ?? 0, getChild: false);
            Get.to(FliterScreen(
              categoryId: dataOfItem[index].id ?? 0,
            ));
          },
          child: Padding(
            padding: EdgeInsets.all(5.r),
            child: Column(
              children: [
                Container(
                  width: 87.03.w,
                  height: 87.03.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(Connection.urlOfCategories(
                          image: dataOfItem[index].image ?? '')),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape
                        .circle, // Use BoxShape.circle to make it circular
                  ),
                ),
                6.ph,
                Container(
                  width: 87.03.w + 5.r + 5.r,
                  child: Text(
                    dataOfItem[index].title ?? '',
                    style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kBlackColor),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
