import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:get/get.dart';

import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/new_arrived_data_apis.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class NewArrivedController extends GetxController {
  RxBool isLoading = false.obs;
  var generalSearchData = GeneralSearchModel().obs;
  RxList dataProducts = [].obs;
  final _api = NewArrivedDataApis();
  int page = 1;

  Future<void> getNewArrivedDataController({int? currentPage}) async {
    try {
      if (currentPage == null) {
        page = page + 1;

        generalSearchData.value = await _api.getNewArrivedDataRequest(
            page: page,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.newArrivals?.data ?? []);
      } else {
        isLoading.value = true;

        page = 1;
        generalSearchData.value = await _api.getNewArrivedDataRequest(
            page: 1,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.value = generalSearchData.value.newArrivals?.data ?? [];
      }
    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      //  FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
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
  updateSortType({required String newKeySort, required String newValueSort}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getNewArrivedDataController(currentPage: 1);
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
    getNewArrivedDataController(currentPage: 1);
  }

  var generalSearchData2 = GeneralSearchModel().obs;
  RxList dataProducts2 = [].obs;
  final _api2 = BrandsDataApis();
  RxBool isLoading2 = false.obs;

  Future<void> getOffersDataController() async {
    isLoading2.value = true;
    try {
      generalSearchData2.value = await _api2.getOffersDataRequest();
      dataProducts2.addAll(generalSearchData2.value.newArrivals?.data ?? []);
    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      // FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      generalSearchData.value = GeneralSearchModel();
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading2.value = false;
  }

  updateToLike({required int index}) {
    // dataProducts[index].update((val) {
    //   val?.wishlist?.add(ProductOptionsModel());
    // });
    generalSearchData.update((val) {
      val?.newArrivals?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }
}
