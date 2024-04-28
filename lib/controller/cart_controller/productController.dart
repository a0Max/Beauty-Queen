// ignore_for_file: file_names

import 'dart:developer';

import 'package:beauty_queen/const/api_connrction/cart_data_apis.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import '../../models/products_model.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/based/error_pop_up.dart';

class ProductController extends GetxController {
  var count = 1.obs;
  final _api = CartDataApis();
  Rx<CartModel> cartData = CartModel().obs;
  RxBool isLoading = false.obs;

  RxDouble totalPrice = 0.0.obs;
  RxInt totalCount = 0.obs;

  getCartData() async {
    try {
      isLoading.value = true;
      cartData.value = await _api.cartDataRequest();
      updatePricesAndCount();
      isLoading.value = false;
    } on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        if (e == 'Check Network connection') {
          ErrorPopUp(message: tr('network_connection'), title: 'خطا');
        } else {
          ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
        }
      }
    }
  }

  arrivedToMax() {
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

  arrivedToMin() {
    var context = Get.context;
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            buttonTwo: false,
            dilougText: tr('youArrivedToMin'),
            buttonOneText: tr('okay'),
          );
        });
  }

  Future<void> increment({required int index}) async {
    ProductsModel? product = cartData.value.products?[index];
    log('${int.parse("${product?.maximum_order_quantity}")}');
    log('${int.parse("${product?.qty}")}');
    log('${(int.parse("${product?.maximum_order_quantity}") > int.parse("${product?.qty}"))}"');
    if ((int.parse("${product?.maximum_order_quantity}") >
            int.parse("${product?.qty}") &&
        num.parse("${product?.stock ?? 1}") >
            int.parse("${product?.qty ?? 1}"))) {
      product?.qty = int.parse("${product.qty ?? 1}") + 1;
      await _api.changeQuantityDataRequest(
          productId: product?.rowId ?? '', productQuantity: product?.qty);
      cartData.update((val) {
        val?.products?[index].qty = product?.qty;
      });
      totalPrice.value =
          totalPrice.value + (1 * double.parse("${product?.price ?? 1}"));
      totalCount.value = totalCount.value + 1;
      update();
    } else {
      arrivedToMax();
    }
  }

  Future<void> decrement({required int index}) async {
    ProductsModel? product = cartData.value.products?[index];
    if (int.parse("${product?.qty ?? 1}") > 1) {
      product?.qty = int.parse("${product.qty ?? 1}") - 1;
      await _api.changeQuantityDataRequest(
          productId: product?.rowId ?? '', productQuantity: product?.qty);
      cartData.update((val) {
        val?.products?[index].qty = product?.qty;
      });
    } else {
      await _api.removeItemDataRequest(productId: product?.rowId ?? '');
      cartData.value.products?.removeAt(index);
    }
    totalPrice.value =
        totalPrice.value - (1 * double.parse("${product?.price ?? 1}"));
    totalCount.value = totalCount.value - 1;
  }

  updatePricesAndCount() {
    cartData.value.products?.forEach((element) {
      totalCount.value = totalCount.value + int.parse("${element.qty ?? 1}");
      totalPrice.value = totalPrice.value +
          (double.parse("${element.qty ?? 1}") *
              double.parse("${element.price ?? 1}"));
    });
  }

  checkCode({required String code}) async {
    await _api.checkPromoCode(code: code);
  }
}
