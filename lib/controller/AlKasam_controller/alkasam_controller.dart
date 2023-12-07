import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/alkasam_data_api.dart';
import '../../const/api_connrction/home_data_apis.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../models/slides_model.dart';
import '../../widgets/error_pop_up.dart';

class AlkasamController extends GetxController {
  RxBool isLoading = true.obs;
  final _api = AlkasamDataApis();
  RxList categoryData = [].obs;

  Future<void> getAlkasamDataController() async {
    try {
      categoryData.value = await _api.categoryDataRequest();

    } on DioException catch (e, s) {
      categoryData.value=[];
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      categoryData.value=[];
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

}