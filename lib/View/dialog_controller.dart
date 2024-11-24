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
    objects.addAll(newObjects);
  }

  Future<void> showDialogSequence() async {
    print('showDialogSequence');
    print('(currentIndex.value < objects.length):${objects.length}');
    if (currentIndex.value < objects.length) {
      final result = await Get.dialog<bool>(
        DialogWidget(
            image: objects[currentIndex.value].mobile?.fullFile ?? '',
            isLink: objects[currentIndex.value].isLink,
            urlLink: objects[currentIndex.value].urlLink,
            linkId: objects[currentIndex.value].linkId,
            linkType: objects[currentIndex.value].linkType,
            onPressBack: () {
              Get.back(result: true);
            }),
        barrierDismissible: true,
      );
      if (result == true || result == null) {
        currentIndex.value++;
        await Future.delayed(const Duration(milliseconds: 300));
        showDialogSequence();
      }
    }
  }

  void onRefresh() {
    currentIndex.value = 0; // Reset to the first object
    showDialogSequence();
  }
}
