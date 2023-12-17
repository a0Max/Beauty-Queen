import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_images.dart';
import '../../const/colors.dart';
import '../../controller/about_controller/about_app_controller.dart';

class MyStickerScreen extends StatefulWidget {
  const MyStickerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStickerScreen();
  }
}

class _MyStickerScreen extends State<MyStickerScreen> {
  final AboutAppController _controller = Get.put(AboutAppController());

  @override
  void initState() {
    super.initState();
    _controller.getMySticker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.h),
          child: CustomAppBar(
            showBagIcon2: false,
            showarrowIcon: true,
            searchBarWidth: 76.w,
          )),
      body: Column(
        children: [
          Image.asset(AppImages.lineOfBadgeImage),
          SizedBox(
            height: 11.h,
          ),
          //////////////contianer/////////////
          Obx(() => SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: kWhiteColor,                   ),
                  child: Column(
                    children: [
                       Container(
                          height: 45.h,
                          width: MediaQuery.of(context).size.width,
                          color: kPrimaryColor,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                'رصيد الملصقات: ${_controller.myStickerData.value.fold<int>(0, (sum, obj) => int.parse("$sum") + int.parse("${obj.queenaAmount}"))}',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w700),


                          ),

                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ///////////////second row/////////////

                      ...List.generate(
                        _controller.myStickerData.value.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 30.w,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kBlackColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100.w,
                                    child: Text(
                                      '${_controller.myStickerData.value[index].createdAt.split('T').first}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kBlackColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        (100.w + 30.w + 20),
                                    child: Text(
                                      ' لقد حصلتي على ${_controller.myStickerData.value[index].queenaAmount} ملصق من الفاتورة #${_controller.myStickerData.value[index].orderId}',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: kBlackColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
