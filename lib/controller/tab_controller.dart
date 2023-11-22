import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabs extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabsController;
  var index = 0.obs;

  @override
  void onInit() {
    tabsController = TabController(length: 2, vsync: this);
    tabsController!.addListener(() {
      index.value = tabsController!.index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabsController!.dispose();
    super.onClose();
  }
}
