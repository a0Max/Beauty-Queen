import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabsTwo extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabsController;

  @override
  void onInit() {
    tabsController = TabController(length: 3, vsync: this);
    tabsController!.animation?.addListener(() {
      // This listener will trigger every time there's an animation tick,
      // i.e., when we're dragging the TabBarView left or right.
      final tabIndex = ((tabsController!.animation?.value ?? 0) + 0.5).floor();
      if (tabIndex != currentTab.value) {
        changeTab(tabIndex);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabsController!.dispose();
    super.onClose();
  }

  RxInt currentTab = 0.obs;

  void changeTab(int tabIndex) {
    currentTab.value = tabIndex;
  }
}
