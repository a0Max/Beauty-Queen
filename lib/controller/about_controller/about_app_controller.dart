import 'package:get/get.dart';

import '../../const/api_connrction/user_data_apis.dart';

class AboutAppController extends GetxController{
  RxBool stateOfMenu = false.obs;

  void changeStateOfMenu() {
      stateOfMenu.value = !stateOfMenu.value;
  }
  final _api = UserDataApis();

  RxList aboutData = [].obs;
  geAbout() async {
    aboutData.value = await _api.getAboutMEDataRequest();
  }

}