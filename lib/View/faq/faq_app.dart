import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/about_controller/about_app_controller.dart';
import '../../controller/faq_controller/faq_app_controller.dart';
import '../../widgets/about_app/item_of_app.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FAQScreen();
  }
}

class _FAQScreen extends State<FAQScreen> {
  final FAQAppController _controller = Get.put(FAQAppController());

  @override
  void initState() {
    super.initState();
    _controller.getFaq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: AppColors.kBlackColor,
              )),
        ],
        title: Text(
          tr('FAQ'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => (_controller.loadingOfMySticker.value &&
                  _controller.fAqData.isEmpty) ==
              true
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              children: [
                20.ph,
                ...List.generate(
                    _controller.fAqData.value.length ?? 0,
                    (index) => ItemOfApp(
                          title: _controller.fAqData.value[index].question,
                          description: _controller.fAqData.value[index].answer,
                        ))
              ],
            )),
    );
  }
}
