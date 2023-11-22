import 'package:get/get.dart';

class ShowDownController extends GetxController{
  RxBool stateOfMenu = false.obs;

  void changeStateOfMenu() {
      stateOfMenu.value = !stateOfMenu.value;
  }

}