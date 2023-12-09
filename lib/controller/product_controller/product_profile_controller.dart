// ignore_for_file: file_names
import 'dart:developer';

import 'package:beauty_queen/const/images.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../const/api_connrction/home_data_apis.dart';
import '../../models/options_model.dart';
import '../../models/product_model.dart';
import '../../widgets/CustomAlertBox.dart';
import '../../widgets/error_pop_up.dart';

class ProductProfileController extends GetxController with GetSingleTickerProviderStateMixin {
  TabController? tabsController;
  var index = 0.obs;
  var productData = ProductModel().obs;
  final _api = HomeDataApis();

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
    // print(selectedOptions.value.isNotEmpty);
    // print(selectedOptions.value.first);
    // print(selectedOptions.value.first);
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

  var count = 1.obs; // Using Rx (observable) to make it reactive

  chooseFirst(){
    var context = Get.context;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            buttonTwo: false,
            dilougText: tr('chooseOptionFirst'),
            buttonOneText: tr('okay'),
          );
        });
  }

  arrivedToMax(){
    var context = Get.context;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            buttonTwo: false,
            dilougText: tr('youArrivedToMax'),
            buttonOneText: tr('okay'),
          );
        });
  }

  arrivedToMin(){
    var context = Get.context;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            buttonTwo:false,
            dilougText:tr('youArrivedToMin'),
            buttonOneText: tr('okay'),
          );
        });
  }

  void increment() {
    if (productData.value.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.value.first == null){
        chooseFirst();
      }else if (int.parse(selectedOptions.first.stock) > count.value) {
        count.value++;
      } else {
        arrivedToMax();
      }
    }else{
      if (int.parse(productData.value.product?.stock??'1') > count.value) {
        count.value++;
      } else {
        arrivedToMax();
      }
    }
  }


  void decrement() {
    print(count.value > 1);
    print(count.value);
    if (productData.value.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.value.first == null){
        chooseFirst();
      }else if ( count.value > 1) {
        count.value--;
      } else {
        arrivedToMin();
      }
    }else{
      if (count.value > 1) {
        count.value--;
      } else {
        arrivedToMin();
      }
    }
  }

  addToCart() async {
    try {
      if (productData.value.productOptions?.isNotEmpty ?? false) {
        for (dynamic selected in selectedOptions) {
          if (selected == null) {
            chooseFirst();
            return;
          }
        }
        await _api.addProductToCart(quantity: count.value,
            productID: productData.value.product?.id ?? 0,
            productOptionID: productData.value.productOptions?.first.id,
            optionID: selectedOptions.value.first.id);
      }else if (selectedOptions.value.isEmpty) {
        await _api.addProductToCart(quantity: count.value,
            productID: productData.value.product?.id ?? 0);
      }
      var context = Get.context;

      showDialog(
          context: context!,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              height: 180.64.h,
              dilougText:
              tr('addedSuccessfully'),
              buttonOneText: tr('continuesShopping'),
              buttonTwoText: tr('continuesOrder'),
            );
          });
    }on DioException catch (e, s) {

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');

    } catch (e, s) {
      log('error:$e');
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');

    }
  }
}
