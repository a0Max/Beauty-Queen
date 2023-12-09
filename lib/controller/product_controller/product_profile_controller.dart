// ignore_for_file: file_names
import 'package:beauty_queen/const/images.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../const/api_connrction/product_data_apis.dart';
import '../../models/options_model.dart';
import '../../models/product_model.dart';

class ProductProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabsController;
  var index = 0.obs;
  var productData = ProductModel().obs;
  final _api = ProductDataApis();

  @override
  void onInit() {
    tabsController = TabController(length: 2, vsync: this);
    tabsController!.addListener(() {
      index.value = tabsController!.index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabsController!.dispose();
    super.onClose();
  }

  getCurrentProduct({required int productId}) async {
    productData.value = await _api.getProductDataRequest(productId: productId);
    selectedOptions.value = List.generate(productData.value.productOptions?.length??0, (index) => null);
  }

  RxList selectedOptions =[].obs;
  updateToSelected({required int index,required OptionsModel? selected }){
    selectedOptions.insert(index, selected);
    selectedOptions.removeAt(index+1);
  }
  

  var selectedSliderIndex = 0.obs;

  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
  }

  var count = 0.obs; // Using Rx (observable) to make it reactive

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}
