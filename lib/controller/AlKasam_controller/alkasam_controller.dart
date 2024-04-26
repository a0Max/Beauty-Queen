import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/alkasam_data_api.dart';
import '../../models/categories_model.dart';
import '../../models/general_search_model.dart';
import '../../models/get_category_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/based/error_pop_up.dart';

class AlkasamController extends GetxController {
  RxBool isLoading = false.obs;
  final _api = AlkasamDataApis();
  RxList categoryData = [].obs;
  RxList childCategoryData = [].obs;
  var generalSearchData = GeneralSearchModel().obs;
  RxList dataProducts = [].obs;

  Future<void> getAlkasamDataController() async {
    try {
      categoryData.value = await _api.categoryDataRequest();
    } on DioException catch (e) {
      categoryData.value = [];
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      categoryData.value = [];
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  RxInt currentCategoryId = 0.obs;
  RxList parentsCategoryData = [].obs;
  Rx<CategoryModel> subCategoryData = CategoryModel().obs;
  updateCurrentCategoryId(
      {required int newId,
      required bool? getChild,
      int? subId,
      bool? notRestartChildren}) async {
    currentCategoryId.value = newId;
    getCategoriesDataController(
        currentPage: 1, getByParent: true, subId: subId);
    childCurrentCategoryId.value = 0;
    if (notRestartChildren != true) {
      childCategoryData.value = [];
      parentsCategoryData.value = [];
      subCategoryData.value = CategoryModel();
    } else {
      childCurrentCategoryId.value = newId;
    }
    if (getChild == true) {
      if (notRestartChildren != true) {
        childCategoryData.value =
            await _api.getChildDataRequest(parentId: currentCategoryId.value);
      }
    } else if (getChild == null) {
      GetCategoryModel value = await _api.getChildDataRequest2(
          parentId: currentCategoryId.value, subId: subId);
      if (notRestartChildren != true) {
        subCategoryData.value = value.category ?? CategoryModel();

        parentsCategoryData.value = value.parents ?? [];

        childCategoryData.value = value.category?.children ?? [];
      }
    }
  }

  RxInt childCurrentCategoryId = 0.obs;
  updateChildCurrentCategoryId({required int newId}) {
    childCurrentCategoryId.value = newId;
    getCategoriesDataController(currentPage: 1, getByParent: false);
  }

  int pageCategory = 1;
  Future<void> getCategoriesDataController(
      {int? currentPage, bool? getByParent, int? subId}) async {
    if (currentPage == 1) {
      generalSearchData.value = GeneralSearchModel();
    }
    try {
      int currentParent = 0;
      if (getByParent == true || childCurrentCategoryId.value == 0) {
        currentParent = currentCategoryId.value;
      } else {
        currentParent = childCurrentCategoryId.value;
      }
      if (currentPage == null) {
        pageCategory = pageCategory + 1;
        GeneralSearchModel tempData = await _api.getCategoryDataRequest(
          page: pageCategory,
          subId: subId,
          keySort: keySort.value,
          selectedLabels: selectedLabels.value,
          selectedPrices: selectedPrices.value,
          selectedBrands: selectedBrands.value,
          categoryId: currentParent,
        );
        generalSearchData.value = tempData;
        dataProducts.addAll(generalSearchData.value.products?.data ?? []);
      } else {
        isLoading.value = true;

        pageCategory = 1;
        generalSearchData.value = await _api.getCategoryDataRequest(
            page: 1,
            subId: subId,
            keySort: keySort.value,
            selectedLabels: selectedLabels.value,
            selectedPrices: selectedPrices.value,
            selectedBrands: selectedBrands.value,
            categoryId: currentParent);
        dataProducts.value = generalSearchData.value.products?.data ?? [];
      }
    } on DioException catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}) {
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getCategoriesDataController(currentPage: 1);
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
    getCategoriesDataController(currentPage: 1);
  }

  updateToLike({required int index}) {
    generalSearchData.update((val) {
      val?.products?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }
}
