import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/brands_data_api.dart';
import '../../models/brand_model.dart';
import '../../models/general_search_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/error_pop_up.dart';

class BrandsController extends GetxController {
  RxBool isLoading = false.obs;
  final _api = BrandsDataApis();
  RxMap brandsData = {}.obs;
  var generalSearchData = GeneralSearchModel().obs;
  int page = 1;
  RxList dataProducts = [].obs;

  Map<String?, List<BrandModel>> groupObjectsByFirstChar(List<BrandModel> objects) {
    Map<String?, List<BrandModel>>? listWeaklyRateData;
    listWeaklyRateData =
        groupBy(objects , (schedule) => schedule.title?[0].toUpperCase()??'#');
    return listWeaklyRateData;
  }

  Future<void> getBrandsDataController() async {
    try {
     final List<BrandModel> tempBrandsData = await _api.breandsDataRequest();
     tempBrandsData.sort((a, b) => a.titleAr?.compareTo(b.titleAr ?? '') ?? 0);
     Map<String?, List<BrandModel>> groupedMap = groupObjectsByFirstChar(tempBrandsData);

     List<MapEntry<String?, List<BrandModel>>> sortedEntries = groupedMap.entries.toList()
       ..sort((a, b) => a.key?.compareTo(b.key??'')??0);

     Map<String?, List<BrandModel>> sortedMap = Map.fromEntries(sortedEntries);

     brandsData.value = sortedMap;
    } on DioException catch (e, s) {
      log('getBrandsDataController:error:$e');
      log('getBrandsDataController:error:$s');

      brandsData.value={};
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      log('getBrandsDataController:error:$e');
      log('getBrandsDataController:error:$s');
      brandsData.value={};
      if (e == 'Check Network connection'){
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      }else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
      // ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

  getDetailsOfBrand({required int idOfBrand, int? currentPage}) async {
    isLoading.value = true;
    try {
      if(currentPage==null){
        page = page +1;
        generalSearchData.value = await _api.getDetailOfBrandsDataRequest(page: page,id:idOfBrand,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.addAll(generalSearchData.value.products?.data??[]);
      }else{
        page = 1;
        generalSearchData.value = await _api.getDetailOfBrandsDataRequest(page: 1,id:idOfBrand,keySort:keySort.value, selectedLabels:selectedLabels.value, selectedPrices:selectedPrices.value, selectedBrands:selectedBrands.value);
        dataProducts.value = generalSearchData.value.products?.data??[];
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
  updateSortType({required String newKeySort, required String newValueSort,required int idOfBrand }){
    keySort.value = newKeySort;
    valueSort.value = newValueSort;
    getDetailsOfBrand(currentPage: 1, idOfBrand:idOfBrand);
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

  applySelected({required int idOfBrand}){
    getDetailsOfBrand(currentPage: 1, idOfBrand:idOfBrand);
  }
  updateToLike({ required int index}){
    // generalSearchData.value.products?.data
      // dataProducts[index].update((val) {
      //   val?.wishlist?.add(ProductOptionsModel());
      // });
    generalSearchData.update((val) {
      val?.products?.data?[index].wishlist?.add(ProductOptionsModel());
    });
  }


}