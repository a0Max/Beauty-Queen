import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../const/api_connrction/alkasam_data_api.dart';
import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/home_data_apis.dart';
import '../../models/brand_model.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../models/slides_model.dart';
import '../../widgets/error_pop_up.dart';

class BrandsController extends GetxController {
  RxBool isLoading = true.obs;
  final _api = BrandsDataApis();
  RxMap brandsData = {}.obs;

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

     // groupedMap.forEach((key, value) {
     //   print('$key:');
     //
     //   for(BrandModel x in value){
     //     print('${x.titleAr}');
     //
     //   }
     // });
     List<MapEntry<String?, List<BrandModel>>> sortedEntries = groupedMap.entries.toList()
       ..sort((a, b) => a.key?.compareTo(b.key??'')??0);

     Map<String?, List<BrandModel>> sortedMap = Map.fromEntries(sortedEntries);

     brandsData.value = sortedMap;
    } on DioException catch (e, s) {
      log('error:$e');
      log('error:$s');

      brandsData.value={};
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e, s) {
      log('error:$e');
      log('error:$s');
      brandsData.value={};
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
    isLoading.value = false;
  }

}