import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/brands_data_api.dart';
import '../../models/brand_model.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class BrandsController extends GetxController {
  RxList characters =
      List.generate(26, (index) => String.fromCharCode(65 + index)).obs;
  RxBool isLoading = false.obs;
  final _api = BrandsDataApis();
  RxMap brandsData = {}.obs;
  List<BrandModel> nonEnglishKeysMap = [];
  var generalSearchData = GeneralSearchModel().obs;
  int page = 1;
  RxList dataProducts = [].obs;

  Map<String?, List<BrandModel>> groupObjectsByFirstChar(
      List<BrandModel> objects) {
    Map<String?, List<BrandModel>>? listWeaklyRateData;
    listWeaklyRateData =
        groupBy(objects, (schedule) => schedule.title?[0].toUpperCase() ?? '#');
    return listWeaklyRateData;
  }

  Map<String?, List<BrandModel>> filterMap(
      Map<String?, List<BrandModel>> originalMap) {
    Map<String?, List<BrandModel>> filteredMap = {};

    originalMap.forEach((key, value) {
      if (isEnglishKey(key)) {
        filteredMap[key] = value;
      } else {
        nonEnglishKeysMap.addAll(value);
      }
    });

    return filteredMap;
  }

  bool isEnglishKey(String? key) {
    if (key == null) {
      return false;
    }

    return key.replaceAll(RegExp(r'[a-zA-Z]'), '') == '';
  }

  Future<void> getBrandsDataController() async {
    isLoading.value = true;

    try {
      if (!characters.value.contains('0-9')) {
        characters.value.add('0-9');
        characters.value.add('');
        characters.value.add('');
        characters.value.add('');
      }
      final List<BrandModel> tempBrandsData = await _api.breandsDataRequest();
      tempBrandsData.sort((a, b) => a.titleAr?.compareTo(b.titleAr ?? '') ?? 0);
      Map<String?, List<BrandModel>> groupedMap =
          groupObjectsByFirstChar(tempBrandsData);

      List<MapEntry<String?, List<BrandModel>>> sortedEntries =
          groupedMap.entries.toList()
            ..sort((a, b) => a.key?.compareTo(b.key ?? '') ?? 0);

      Map<String?, List<BrandModel>> sortedMap = Map.fromEntries(sortedEntries);
      sortedMap = filterMap(sortedMap);
      if (nonEnglishKeysMap.isNotEmpty) {
        sortedMap.addAll({'0-9': nonEnglishKeysMap});
      }
      brandsData.value = sortedMap;
    } on DioException catch (e, s) {
      log('getBrandsDataController:error:$e');
      log('getBrandsDataController:error:$s');

      brandsData.value = {};
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      log('getBrandsDataController:error:$e');
      log('getBrandsDataController:error:$s');
      brandsData.value = {};
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
      // ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

  getDetailsOfBrand({required int idOfBrand, int? currentPage}) async {
    try {
      if (currentPage == null) {
        page = page + 1;
        generalSearchData.value = await _api.getDetailOfBrandsDataRequest(
            page: page,
            id: idOfBrand,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.products?.data ?? []);
      } else {
        isLoading.value = true;

        page = 1;
        generalSearchData.value = await _api.getDetailOfBrandsDataRequest(
            page: 1,
            id: idOfBrand,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.value = generalSearchData.value.products?.data ?? [];
      }
    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      generalSearchData.value = GeneralSearchModel();
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType(
      {required String newKeySort,
      required String newValueSort,
      required int idOfBrand}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getDetailsOfBrand(currentPage: 1, idOfBrand: idOfBrand);
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

  applySelected({required int idOfBrand}) {
    getDetailsOfBrand(currentPage: 1, idOfBrand: idOfBrand);
  }

  updateToLike({required int index}) {
    // generalSearchData.value.products?.data
    // dataProducts[index].update((val) {
    //   val?.wishlist?.add(ProductOptionsModel());
    // });
    generalSearchData.update((val) {
      val?.products?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }
}
