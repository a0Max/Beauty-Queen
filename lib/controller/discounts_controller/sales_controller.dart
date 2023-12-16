import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/home_data_apis.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/error_pop_up.dart';

class SalesController extends GetxController {
  RxBool isLoading = false.obs;
  var generalSearchData = GeneralSearchModel().obs;
  RxList dataProducts = <SalesProductsModel>[].obs;
  final _api = HomeDataApis();
  int page = 1;

  Future<void> getSalesDataController({int? currentPage}) async {
    isLoading.value = true;
    try {
      if(currentPage==null){
        page = page +1;

        generalSearchData.value = await _api.getSalesDataRequest(page: page,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.sales?.data??[]);
      }else{
        page = 1;
        generalSearchData.value = await _api.getSalesDataRequest(page: 1,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.value = generalSearchData.value.sales?.data??[];
      }

    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      generalSearchData.value = GeneralSearchModel();
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}){
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getSalesDataController(currentPage: 1);
  }

  RxList selectedLabels = [].obs;
  updateSelectedLabel({required int newSelected}){
    if (selectedLabels.value.contains("$newSelected")){
      selectedLabels.remove("$newSelected");
    }else {
      selectedLabels.add("$newSelected");
    }

  }

  RxList selectedPrices = [].obs;
  updateSelectedPrices({required int newSelected}){
    if (selectedPrices.value.contains("$newSelected")){
      selectedPrices.remove("$newSelected");
    }else {
      selectedPrices.add("$newSelected");
    }
  }


  RxList selectedBrands = [].obs;
  updateSelectedBrands({required int newSelected}){
    if (selectedBrands.value.contains("$newSelected")){
      selectedBrands.remove("$newSelected");
    }else {
      selectedBrands.add("$newSelected");
    }
  }

  clearSelected(){
    selectedBrands.clear();
    selectedPrices.clear();
    selectedLabels.clear();
  }

  applySelected(){
    getSalesDataController(currentPage: 1);
  }

  updateToLike({ required int index}) {
    generalSearchData.update((val) {
      val?.sales?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }

}
