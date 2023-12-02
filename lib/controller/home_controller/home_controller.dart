import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/home_data_apis.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../models/slides_model.dart';
import '../../widgets/error_pop_up.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  var homeData = HomeModel().obs;
  final _api = HomeDataApis();
  RxList sliders = [].obs;

  Future<void> getHomeDataController() async {
    try {
      homeData.value = await _api.HomeDataRequest();
      sliders.value =
      (homeData.value.slides?.where((element) => element.mobile != null)
          .toList() ?? []);
    } on DioException catch (e, s) {
      homeData.value=HomeModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      homeData.value=HomeModel();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

  RxInt currentSlider = 0.obs;
  updateCurrentSlider({required int newSlider}){
    currentSlider.value = newSlider;
  }


  RxInt currentOffer = 0.obs;
  updateCurrentOffer({required int newSlider}){
    currentOffer.value = newSlider;
  }


  RxInt currentSalesProducts = 0.obs;
  updateSalesProducts({required int newSlider}){
    currentSalesProducts.value = newSlider;
  }

}