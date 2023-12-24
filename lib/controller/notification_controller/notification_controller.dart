import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/app_data_apis.dart';
import '../../widgets/based/error_pop_up.dart';

class NotificationController extends GetxController {
  final _api = AppDataApis();
  RxList notificationList = [].obs;
  RxBool loadingNotification = false.obs;
  getAllNotification() async {
    try {
      loadingNotification.value = true;

      notificationList.value = await _api.getNotificationsDataRequest();
    } on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    loadingNotification.value = false;
  }
}
