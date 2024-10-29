import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogController extends GetxController {
  RxBool isDialogVisible = false.obs;
  Timer? _timer;
  List<String> excludedScreens = [
    "ScreenA",
    "ScreenB"
  ]; // List screens to exclude

  // Method to show dialog
  void showDialog(BuildContext context, Widget dialogContent) {
    if (isDialogVisible.value) return; // Prevent showing if already visible

    isDialogVisible.value = true;

    // Show the dialog
    Get.dialog(
      dialogContent,
      barrierDismissible: false,
    ).then((_) {
      // When dialog closes, reset visibility and start the timer
      isDialogVisible.value = false;
      _startTimer(context, dialogContent);
    });
  }

  // Timer to show dialog after 5 minutes
  void _startTimer(BuildContext context, Widget dialogContent) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer(Duration(minutes: 5), () {
      if (!_isScreenExcluded()) {
        showDialog(context, dialogContent);
      }
    });
  }

  // Helper to check if the current screen is excluded
  bool _isScreenExcluded() {
    String? currentRoute = Get.currentRoute;
    return excludedScreens.contains(currentRoute);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
