import 'dart:async';

import 'package:beauty_queen/View/auth_view/login_page.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var firstProgressValue = 0.0.obs;
  var secondProgressValue = 0.0.obs;
  var threeProgressValue = 0.0.obs;
  var fourProgressValue = 0.0.obs;
  var showProgress = true.obs;
  var cancelTimerFlag = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startProgress();
  }

  void _startProgress() async {
    // Run the first progress bar and wait for 5 seconds
    if (!cancelTimerFlag.value) {
      await _runProgress(firstProgressValue);
    }

    if (!cancelTimerFlag.value) {
      await _runProgress(secondProgressValue);
    }

    if (!cancelTimerFlag.value) {
      await _runProgress(fourProgressValue);
      // After the second progress bar is complete, check the flag again
      // before navigating to the login screen
    }
    if (!cancelTimerFlag.value) {
      await _runProgress(fourProgressValue);
      // After the second progress bar is complete, check the flag again
      // before navigating to the login screen
      if (!cancelTimerFlag.value) {
        // Navigate to the login screen
        _navigateToLoginScreen();
      }
    }
  }

  Future<void> _runProgress(RxDouble progressValue) async {
    int totalTime = 5000; // 5 seconds
    int stepTime = 35; // Step time in milliseconds
    int numSteps = totalTime ~/ stepTime;
    double stepValue = 1.0 / numSteps;

    while (progressValue.value < 3.0) {
      await Future.delayed(Duration(milliseconds: stepTime));
      if (cancelTimerFlag.value) {
        // Exit the loop and cancel the timer
        return;
      }
      progressValue.value += stepValue;
    }
  }

  void _navigateToLoginScreen() {
    // Implement the navigation logic here, e.g., using Get.to() if using GetX for navigation
    Get.off(const LogInPage());
  }

  void cancelTimer() {
    cancelTimerFlag.value = true;
    _timer?.cancel();
  }
}
