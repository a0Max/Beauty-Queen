import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPopUp {
  ErrorPopUp({String? title, String? message, bool? isError}) {
    Get.snackbar(
      title ?? tr('Error'),
      message ?? tr('something_wrong'),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
      backgroundColor: isError == false ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }
}
