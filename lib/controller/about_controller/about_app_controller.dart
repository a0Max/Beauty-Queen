import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../const/api_connrction/user_data_apis.dart';

class AboutAppController extends GetxController {
  RxBool stateOfMenu = false.obs;

  void changeStateOfMenu() {
    stateOfMenu.value = !stateOfMenu.value;
  }

  final _api = AppDataApis();

  RxList aboutData = [].obs;
  geAbout() async {
    aboutData.value = await _api.getAboutMEDataRequest();
  }

  RxBool loadingOfMySticker = false.obs;

  RxList myStickerData = [].obs;
  getMySticker() async {
    loadingOfMySticker.value = true;
    myStickerData.value = await _api.getTransactionsataRequest();
    loadingOfMySticker.value = false;
  }
}
