import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPopUp{
  ErrorPopUp({String? title, String? message}){
    Get.snackbar(
      title??tr('Error'),
      message??tr('something_wrong'),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 7),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
