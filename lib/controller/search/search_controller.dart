import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/search_data_apis.dart';
import '../../models/brand_model.dart';
import '../../models/general_search_model.dart';
import '../../widgets/error_pop_up.dart';

class SearchController0 extends GetxController {
  RxBool isLoading = true.obs;
  final _api = SearchDataApis();
  var generalSearchData = GeneralSearchModel().obs;
  int page = 1;
  RxList dataProducts = [].obs;
  RxString keyWord = ''.obs;

  getSearchDetails({required String subKeyWord, int? currentPage}) async {
    try {
      keyWord.value = subKeyWord;
      if(currentPage==null){
        page = page +1;
        generalSearchData.value = await _api.getSearchDataRequest(page: page,keyWord:subKeyWord,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.products?.data??[]);
      }else{
        page = 1;
        generalSearchData.value = await _api.getSearchDataRequest(page: 1,keyWord:subKeyWord,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.value = generalSearchData.value.products?.data??[];
      }
    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}){
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getSearchDetails(currentPage: 1, subKeyWord:keyWord.value);
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
    getSearchDetails(currentPage: 1, subKeyWord:keyWord.value);
  }


}