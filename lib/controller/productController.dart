// ignore_for_file: file_names

import 'package:get/get.dart';

class ProductController extends GetxController {
  var count = 0.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    count.value--;
  }
}
