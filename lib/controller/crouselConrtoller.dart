// ignore_for_file: file_names
import 'package:beauty_queen/const/images.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CarouselsController extends GetxController {
  var currentTab = 0.obs;

  void changeTab(int tabIndex) {
    currentTab.value = tabIndex;
  }

  var selectedTabIndex = 0.obs; // Store the selected tab index

  // Define your list of screens (you can use Widgets)
  final List<Widget> screens = [
    // Add your actual screens here
  ];
  final List<ImageModel> images = [
    ImageModel(kgelImage),
    ImageModel(kgelImage),
    ImageModel(kgelImage),
  ];

  void toggleFavorite(int index) {
    print("Toggling favorite for index $index");
    images[index].isFavorite = !images[index].isFavorite;
    print("Is favorite: ${images[index].isFavorite}");
    update();
  }

  void changeTabIndex(int index) {
    selectedTabIndex.value = index; // Update the selected tab index
  }

  var count = 0.obs; // Using Rx (observable) to make it reactive

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}

class ImageModel {
  final String imagePath;
  bool isFavorite;

  ImageModel(this.imagePath, {this.isFavorite = false});
}
