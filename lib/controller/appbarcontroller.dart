import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController {
  final ScrollController scrollController = ScrollController();
  var isScrolled = false.obs;
  var searchBarWidth = 1.0.obs;
  var searchBarTranslationX = 0.0.obs;
  var searchBarTranslationY = 0.0.obs;

  void scrollListener() {
    if (scrollController.offset > 0 && isScrolled.value == false) {
      isScrolled(true);
      searchBarWidth(0.75);
      searchBarTranslationX(50.0);
      searchBarTranslationY(-52.0);
    } else if (scrollController.offset <= 0 && isScrolled.value == true) {
      isScrolled(false);
      searchBarWidth(1.0);
      searchBarTranslationX(0.0);
      searchBarTranslationY(0.0);
    }
  }

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}
