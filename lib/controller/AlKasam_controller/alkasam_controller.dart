import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/alkasam_data_api.dart';
import '../../const/api_connrction/home_data_apis.dart';
import '../../models/categories_model.dart';
import '../../models/general_search_model.dart';
import '../../models/home_model.dart';
import '../../models/slides_model.dart';
import '../../widgets/error_pop_up.dart';

class AlkasamController extends GetxController {
  RxBool isLoading = true.obs;
  final _api = AlkasamDataApis();
  RxList categoryData = [].obs;
  RxList childCategoryData = [].obs;
  var generalSearchData = GeneralSearchModel().obs;
  RxList dataProducts = [].obs;

  Future<void> getAlkasamDataController() async {
    try {
      categoryData.value = await _api.categoryDataRequest();

    } on DioException catch (e, s) {
      categoryData.value=[];
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      categoryData.value=[];
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

  RxInt currentCategoryId = 0.obs;
  updateCurrentCategoryId({required int newId, required bool getChild}) async {
    currentCategoryId.value = newId;
    getCategoriesDataController(currentPage: 1, getByParent: true);
    if (getChild == true){
      childCategoryData.value = await _api.getChildDataRequest(parentId:currentCategoryId.value);
    }
  }

  RxInt childCurrentCategoryId = 0.obs;
  updateChildCurrentCategoryId({required int newId}){
    childCurrentCategoryId.value = newId;
    getCategoriesDataController(currentPage: 1, getByParent:false);
  }

  int pageCategory = 1;
  Future<void> getCategoriesDataController({int? currentPage, bool? getByParent}) async {
    try {
      int currentParent = 0;
      if(getByParent == true){
        currentParent = currentCategoryId.value;
      }else{
        currentParent = childCurrentCategoryId.value;
      }
      if(currentPage==null){
        pageCategory = pageCategory +1;

        generalSearchData.value = await _api.getCategoryDataRequest(page: pageCategory,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value, categoryId: currentParent, );
        dataProducts.addAll(generalSearchData.value.products?.data??[]);
      }else{
        pageCategory = 1;
        generalSearchData.value = await _api.getCategoryDataRequest(page: 1,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value,categoryId: currentParent);
        dataProducts.value = generalSearchData.value.products?.data??[];
      }
    } on DioException catch (e, s) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      generalSearchData.value = GeneralSearchModel();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  var keySort = RxString('');
  var valueSort = RxString('');
  updateSortType({required String newKeySort, required String newValueSort}){
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getCategoriesDataController(currentPage: 1);
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
    getCategoriesDataController(currentPage: 1);
  }



}