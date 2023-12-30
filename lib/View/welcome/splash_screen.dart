import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../controller/auth_controller/auth_controler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  final AuthController controller = Get.put(AuthController());
  Upgrader upgraderData = Upgrader.sharedInstance;

  @override
  void initState() {
    super.initState();
    upgraderData.onLater = () {
      initData();
      return true;
    };
    upgraderData.onIgnore = () {
      initData();
      return true;
    };
    print(
        "${upgraderData.isUpdateAvailable().runtimeType}:upgraderData.isUpdateAvailable():${upgraderData.isUpdateAvailable()}");
    if (upgraderData.isUpdateAvailable() == false) {
      initData();
    }
  }

  initData() {
    controller.startProgress();
    controller.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
          upgrader: upgraderData,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.imageLogoLogin,
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return Visibility(
                    visible: controller.showProgress.value,
                    child: Stack(
                      children: [
                        Container(
                          width: 238,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: AppColors
                                .klPinkColor, // I assumed a light pink background. Adjust as needed.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        Container(
                          width: 238 * controller.progressValue.value,
                          height: 6,
                          decoration: ShapeDecoration(
                            color: AppColors.kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          )),
    );
  }
}
