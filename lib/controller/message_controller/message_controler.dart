
import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';

class MessageController extends GetxController {
  final _api = AppDataApis();

  sendMessageToManagies(
      {required String phone, required String message}) async {
    await _api.sendMessageRequest(phone: phone, message: message);
  }
}
