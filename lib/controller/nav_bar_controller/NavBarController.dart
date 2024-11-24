// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../const/api_connrction/home_data_apis.dart';

class NavController extends GetxController {
  //////////////// Bottom Navigation Bar /////////////
  final RxInt _currentIndex = 0.obs;
  RxInt countCart = 0.obs;
  final _api = HomeDataApis();
  static NavController get to => Get.find(); // Get reference to ControllerB
  RxInt get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    _currentIndex.value = newIndex;
  }

  getCountOfCart() async {
    countCart.value = await _api.getCartRequest();
    print('countCart.value:${countCart.value}');
    update();
  }
}
