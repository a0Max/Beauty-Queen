import 'package:get/get.dart';

import '../../const/api_connrction/home_data_apis.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../models/slides_model.dart';

class HomeController extends GetxController {
  var homeData = HomeModel().obs;
  final _api = HomeDataApis();
  RxList sliders = [].obs;

  Future<void> getHomeDataController() async {
    homeData.value = await _api.HomeDataRequest();
    print(homeData.value.newItems?.length);
    sliders.value = (homeData.value.slides?.where((element) => element.mobile!=null).toList()??[]);

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