import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OTPController extends GetxController {
  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  var isFocused1 = false.obs;
  var isFocused2 = false.obs;
  var isFocused3 = false.obs;
  var isFocused4 = false.obs;

  @override
  void onInit() {
    super.onInit();

    focusNode1.addListener(() {
      isFocused1.value = focusNode1.hasFocus;
    });

    focusNode2.addListener(() {
      isFocused2.value = focusNode2.hasFocus;
    });

    focusNode3.addListener(() {
      isFocused3.value = focusNode3.hasFocus;
    });

    focusNode4.addListener(() {
      isFocused4.value = focusNode4.hasFocus;
    });
  }

  @override
  void onClose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.onClose();
  }
}
