import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/about_controller/about_app_controller.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../widgets/about_app/item_of_app.dart';
import '../../widgets/dialog_widget.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../dialog_controller.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutAppScreen();
  }
}

class _AboutAppScreen extends State<AboutAppScreen> {
  final AboutAppController _controller = Get.put(AboutAppController());

  @override
  void initState() {
    super.initState();
    _controller.geAbout();
    showDialog();
  }

  final DialogController dialogController = Get.put(DialogController());
  showDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dialogController.addObjects(Get.find<AuthController>().popData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
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
          tr('about_us'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: AppColors.kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(() => (_controller.loadingOfMySticker.value &&
                  _controller.aboutData.isEmpty) ==
              true
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              children: [
                20.ph,
                ...List.generate(
                    _controller.aboutData.value.length ?? 0,
                    (index) => ItemOfApp(
                          title: _controller.aboutData.value[index].title,
                          description:
                              _controller.aboutData.value[index].description,
                        ))
              ],
            )),
    );
  }
}
