// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  var selectedIndex = 0.obs;
  final RxBool isLineVisible = false.obs;
  Color containerColor = Colors.white;

  RxBool isSelected = true.obs;
  var selectedValue = ''.obs;
  var selectedValue2 = ''.obs;
  var selectedValue3 = ''.obs;
  final List<String> dropdownItems = [
    'طرابلس'
        'عين زارة'
        'بجانب مول طرابلس للتسوق'
  ];
  void changeTab(int index) {
    selectedIndex.value = index;
  }
  // Create an observable variable to track the radio button state

  void updateSelection(bool value) {
    isSelected.value = value;
  }

  var selectedPaymentMethod2 = 'الاستلام بخدمة التوصيل'.obs;

  void selectPaymentMethod2(String value) {
    selectedPaymentMethod2.value = value;
  }

  var selectedPaymentMethod = 'cash'.obs;

  void selectPaymentMethod(String value) {
    selectedPaymentMethod.value = value;
  }

  void showLine() {
    isLineVisible.value = true;
  }
}
