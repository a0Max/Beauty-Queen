// ignore_for_file: file_names

import 'dart:developer';

import 'package:get/get.dart';

class HomeController extends GetxController {
  var searchBarWidth = 1.0.obs;
  var searchBarTranslationX = 0.0.obs;
  var searchBarTranslationY = 0.0.obs;
  var isScrolled = false.obs;

  void onScroll(double offset) {
    log('Scroll offset: $offset');
    if (offset > 0 && !isScrolled.value) {
      log('Scrolling down');
      isScrolled.value = true;
      searchBarWidth.value = 0.75;
      searchBarTranslationX.value = 50.0;
      searchBarTranslationY.value = -52.0;
    } else if (offset <= 0 && isScrolled.value) {
      log('Scrolling up');
      isScrolled.value = false;
      searchBarWidth.value = 1.0;
      searchBarTranslationX.value = 0.0;
      searchBarTranslationY.value = 0.0;
    }
  }
}
