// ignore_for_file: file_names

import '../View/welcome_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  var progressValue = 0.0.obs;
  var showProgress = true.obs;

  @override
  void onInit() {
    super.onInit();
    _startProgress();
  }

  void _startProgress() async {
    while (progressValue.value < 1.0) {
      await Future.delayed(const Duration(milliseconds: 25));
      progressValue.value += 0.01;
    }
    showProgress.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
    Get.off(() => WelcomeScreen());
  }
}
