import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/queen_data_apis.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/error_pop_up.dart';

class QueenOfferController extends GetxController with GetSingleTickerProviderStateMixin {

  RxInt currentTab = 0.obs;

  void changeTab(int tabIndex) {
    currentTab.value = tabIndex;
  }

  final _api = QueenDataApis();
  var generalSearchData = GeneralSearchModel().obs;
  RxBool isLoading = false.obs;
  int page = 1;
  RxList dataProducts = [].obs;


  Future<void> getQueenOfferDataController({int? currentPage}) async {
    try {
      if(currentPage==null){
        page = page +1;

        generalSearchData.value = await _api.getQueenOffersDataRequest(page: page,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.offers?.data??[]);
      }else{
        isLoading.value = true;
        page = 1;
        generalSearchData.value = await _api.getQueenOffersDataRequest(page: 1,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.value = generalSearchData.value.offers?.data??[];
      }
    } on DioException catch (e) {
      log('getQueenOfferDataController:error:$e');
      generalSearchData.value = GeneralSearchModel();
    } catch (e) {
      log('getQueenOfferDataController:error:$e');
      generalSearchData.value = GeneralSearchModel();
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }


  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}){
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getQueenOfferDataController(currentPage: 1);
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
    getQueenOfferDataController(currentPage: 1);
  }
  updateToLike({ required int index}){
    dataProducts[index].update((val) {
      val?.wishlist?.add(ProductOptionsModel());
    });
  }
}
