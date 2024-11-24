import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../models/get_contact.dart';
import '../../models/transactions_model.dart';

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

  var myStickerData = TotalOfTransactionsModel().obs;
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
