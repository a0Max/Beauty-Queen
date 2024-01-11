import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/search_data_apis.dart';
import '../../models/general_quick_search_model.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class SearchController0 extends GetxController {
  RxBool isLoading = false.obs;
  final _api = SearchDataApis();
  var generalSearchData = GeneralSearchModel().obs;
  var generalQuickSearchData = GeneralQuickSearchModel().obs;
  RxBool loadingQuickSearch = false.obs;
  int page = 1;
  RxList dataProducts = [].obs;
  RxString keyWord = ''.obs;

  getSearchDetails({required String subKeyWord, int? currentPage}) async {
    if (currentPage == 1) {
      generalSearchData.value = GeneralSearchModel();
      dataProducts.value = [];
    }
    try {
      keyWord.value = subKeyWord;
      if (currentPage == null) {
        page = page + 1;
        generalSearchData.value = await _api.getSearchDataRequest(
            page: page,
            keyWord: subKeyWord,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.products?.data ?? []);
      } else {
        isLoading.value = true;

        page = 1;
        generalSearchData.value = await _api.getSearchDataRequest(
            page: 1,
            keyWord: subKeyWord,
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

  getTheQuickSearch({required String keyWord}) async {
    loadingQuickSearch.value = true;
    this.keyWord.value = keyWord;

    generalQuickSearchData.value = await _api.getQuickSearchDataRequest(
      keyWord: keyWord,
    );
    loadingQuickSearch.value = false;
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getSearchDetails(currentPage: 1, subKeyWord: keyWord.value);
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
    getSearchDetails(currentPage: 1, subKeyWord: keyWord.value);
  }

  updateToLike({required int index}) {
    // dataProducts[index].update((val) {
    //   val?.wishlist?.add(ProductOptionsModel());
    // });
    generalSearchData.update((val) {
      val?.products?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }
}
