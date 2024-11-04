import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/pop_up_model.dart';
import '../widgets/dialog_widget.dart';

class DialogController extends GetxController {
  RxList<PopUpModel> objects = <PopUpModel>[].obs;
  final RxInt currentIndex = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   showDialogSequence();
  // }
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ever(objects, (_) => showDialogSequence());
      showDialogSequence();
    });
  }

  void addObjects(List<PopUpModel> newObjects) {
    objects.addAll(newObjects); // Adds and triggers the observer
  }

  void showDialogSequence() {
    print('showDialogSequence');
    print('(currentIndex.value < objects.length):${objects.length}');
    if (currentIndex.value < objects.length) {
      Get.dialog(
        DialogWidget(
          image: objects[currentIndex.value].mobile?.fullFile ?? '',
          isLink: objects[currentIndex.value].isLink,
          urlLink: objects[currentIndex.value].urlLink,
          linkId: objects[currentIndex.value].linkId,
          linkType: objects[currentIndex.value].linkType,
        ),
        barrierDismissible: false, // Prevent dialog from being dismissed
      );
    }
  }

  void onRefresh() {
    currentIndex.value = 0; // Reset to the first object
    showDialogSequence();
  }
}
