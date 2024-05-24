import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
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
          // preferredSize: Size.fromHeight(100.h),
          child: CustomAppBar(
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
          Obx(() => _controller.loadingOfMySticker.value == true
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.kWhiteColor,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 45.h,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.kPrimaryColor,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            'رصيد الملصقات: ${_controller.myStickerData.value.queenaBalance}',
                            style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ///////////////second row/////////////

                        ...List.generate(
                          _controller
                                  .myStickerData.value.transactions?.length ??
                              0,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 30.w,
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kBlackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        '${_controller.myStickerData.value.transactions?[index].createdAt?.split('T').first}',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kBlackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    if (_controller.myStickerData.value
                                            .transactions?[index].type ==
                                        'add') ...{
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                (100.w + 30.w + 20),
                                        child: Text(
                                          ' لقد حصلتي على ${_controller.myStickerData.value.transactions?[index].queenaAmount} ملصق من الفاتورة #${_controller.myStickerData.value.transactions?[index].orderId}',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kBlackColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    } else if (_controller.myStickerData.value
                                            .transactions?[index].type ==
                                        'deduction') ...{
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                (100.w + 30.w + 20),
                                        child: Text(
                                          ' تم سحب ${_controller.myStickerData.value.transactions?[index].queenaAmount} ملصق من الفاتورة #${_controller.myStickerData.value.transactions?[index].orderId}',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.kBlackColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    }
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
