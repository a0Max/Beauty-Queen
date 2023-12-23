import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../const/api_connrction/user_data_apis.dart';

class FAQAppController extends GetxController {
  RxBool stateOfMenu = false.obs;

  void changeStateOfMenu() {
    stateOfMenu.value = !stateOfMenu.value;
  }

  final _api = AppDataApis();
  RxBool loadingOfMySticker = false.obs;

  RxList fAqData = [].obs;
  getFaq() async {
    loadingOfMySticker.value = true;

    fAqData.value = await _api.getFAQDataRequest();
    loadingOfMySticker.value = false;
  }
}
