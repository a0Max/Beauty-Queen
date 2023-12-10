// ignore_for_file: file_names

import 'package:beauty_queen/const/api_connrction/cart_data_apis.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/vars.dart';
import '../models/brand_model.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import '../widgets/CustomAlertBox.dart';

class ProductController extends GetxController {
  var count = 1.obs;
  final _api = CartDataApis();
  Rx<CartModel> cartData = CartModel().obs ;

  getCartData() async {
    cartData.value =await  _api.cartDataRequest();
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

  Future<void> increment({required int index}) async {
    print('old:${cartData.value.products?[index].qty}');
    ProductsModel? product = cartData.value.products?[index];
    if (int.parse("${product?.stock??1}")>int.parse("${product?.qty??1}")){
      product?.qty = int.parse("${product.qty??1}") + 1;
      await _api.changeQuantityDataRequest(productId: product?.id??0, productQuantity: product?.qty);
      cartData.update((val) {
        val?.products?[index].qty = product?.qty;
      });
      // cartData.value.products?[index].qty = product?.qty;
      print('new:${cartData.value.products?[index].qty}');
      update();
    }else{
      arrivedToMax();
    }
  }

  Future<void> decrement({required int index}) async {
    ProductsModel? product = cartData.value.products?[index];
    if (int.parse("${product?.qty??1}")>1){
      product?.qty = int.parse("${product.qty??1}") - 1;
      await _api.changeQuantityDataRequest(productId: product?.id??0, productQuantity: product?.qty);
      cartData.update((val) {
        val?.products?[index].qty = product?.qty;
      });
    }else{
      cartData.value.products?.removeAt(index);
    }
  }
}
