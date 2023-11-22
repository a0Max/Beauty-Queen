// ignore_for_file: file_names

import 'package:get/get.dart';

class NavController extends GetxController {
  //////////////// Bottom Navigation Bar /////////////
  final RxInt _currentIndex = 0.obs;

  RxInt get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex.value = newIndex;
  }
}
