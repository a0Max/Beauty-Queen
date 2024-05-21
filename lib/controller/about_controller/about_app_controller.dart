import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../models/get_contact.dart';

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

  RxBool isLoading = false.obs;
  GetContactModel myContactData = GetContactModel();
  getMyContact() async {
    isLoading.value = true;
    myContactData = await _api.getContactUs();
    isLoading.value = false;
    update();
  }
}
