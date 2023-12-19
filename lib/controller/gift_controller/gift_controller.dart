import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/gifts_data_apis.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class GiftController extends GetxController {
  RxBool isLoading = false.obs;
  var generalSearchData = GeneralSearchModel().obs;
  RxList dataProducts = [].obs;
  final _api = GiftsDataApis();
  int page = 1;

  Future<void> getGiftsDataController({int? currentPage}) async {
    isLoading.value = true;
    try {
      if (currentPage == null) {
        page = page + 1;

        generalSearchData.value = await _api.getGiftsDataRequest(
            page: page,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.gifts?.data ?? []);
      } else {
        page = 1;
        generalSearchData.value = await _api.getGiftsDataRequest(
            page: 1,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.value = generalSearchData.value.gifts?.data ?? [];
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
  updateSortType({required String newKeySort, required String newValueSort}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getGiftsDataController(currentPage: 1);
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
    getGiftsDataController(currentPage: 1);
  }

  var generalSearchData2 = GeneralSearchModel().obs;
  RxList dataProducts2 = [].obs;
  final _api2 = BrandsDataApis();
  RxBool isLoading2 = false.obs;

  Future<void> getOffersDataController() async {
    isLoading2.value = true;
    try {
      generalSearchData2.value = await _api2.getOffersDataRequest();
      dataProducts2.addAll(generalSearchData2.value.gifts?.data ?? []);
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
    isLoading2.value = false;
  }

  updateToLike({required int index}) {
    // dataProducts[index].update((val) {
    //   val?.wishlist?.add(ProductOptionsModel());
    // });
    generalSearchData.update((val) {
      val?.gifts?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }
}
