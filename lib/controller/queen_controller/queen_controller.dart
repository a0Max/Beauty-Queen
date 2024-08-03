import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/queen_data_apis.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class QueenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabsController;

  @override
  void onInit() {
    print('onInit');
    tabsController = TabController(length: 3, vsync: this);
    tabsController!.animation?.addListener(() {
      final tabIndex = ((tabsController!.animation?.value ?? 0) + 0.5).floor();
      if (tabIndex != currentTab.value) {
        changeTab(tabIndex);
      }
    });
    super.onInit();
  }

  @override
  void refresh() {
    print('refresh');
  }

  @override
  void onClose() {
    tabsController!.dispose();
    super.onClose();
  }

  RxInt currentTab = 0.obs;

  Future<void> changeTab(int tabIndex) async {
    currentTab.value = tabIndex;
  }

  final _api = QueenDataApis();
  var generalSearchData = GeneralSearchModel().obs;
  RxBool isLoading = false.obs;
  int page = 1;
  RxList dataProducts = [].obs;

  Future<void> getQueenDataController({int? currentPage}) async {
    try {
      if (currentPage == null) {
        page = page + 1;

        generalSearchData.value = await _api.getQueenDataRequest(
            page: page,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.products?.data ?? []);
      } else {
        isLoading.value = true;

        page = 1;
        generalSearchData.value = await _api.getQueenDataRequest(
            page: 1,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.value = generalSearchData.value.products?.data ?? [];
      }
    } on DioException catch (e) {
      log('getQueenDataController:error:$e');
      generalSearchData.value = GeneralSearchModel();
      // ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      //  FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      log('getQueenDataController:error:$e');
      generalSearchData.value = GeneralSearchModel();
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getQueenDataController(currentPage: 1);
  }

  RxList selectedLabels = [].obs;
  updateSelectedLabel({required int newSelected}) {
    if (selectedLabels.value.contains("$newSelected")) {
      selectedLabels.remove("$newSelected");
    } else {
      selectedLabels.add("$newSelected");
    }
  }

  RxList selectedPrices = [].obs;
  updateSelectedPrices({required int newSelected}) {
    if (selectedPrices.value.contains("$newSelected")) {
      selectedPrices.remove("$newSelected");
    } else {
      selectedPrices.add("$newSelected");
    }
  }

  RxList selectedBrands = [].obs;
  updateSelectedBrands({required int newSelected}) {
    if (selectedBrands.value.contains("$newSelected")) {
      selectedBrands.remove("$newSelected");
    } else {
      selectedBrands.add("$newSelected");
    }
  }

  clearSelected() {
    selectedBrands.clear();
    selectedPrices.clear();
    selectedLabels.clear();
  }

  applySelected() {
    getQueenDataController(currentPage: 1);
  }

  updateToLike({required int index}) {
    dataProducts[index].update((val) {
      val?.wishlist?.add(ProductOptionsModel());
    });
  }
}
