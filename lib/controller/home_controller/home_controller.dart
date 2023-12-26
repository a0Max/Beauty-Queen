import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/cart/cart_screen.dart';
import '../../const/api_connrction/home_data_apis.dart';
import '../../models/home_model.dart';
import '../../models/product_options_model.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/based/error_pop_up.dart';
import '../nav_bar_controller/NavBarController.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  var homeData = HomeModel().obs;
  final _api = HomeDataApis();
  RxList sliders = [].obs;

  Future<void> getHomeDataController() async {
    try {
      homeData.value = await _api.homeDataRequest();
      sliders.value = (homeData.value.slides
              ?.where((element) => element.mobile != null)
              .toList() ??
          []);
    } on DioException catch (e) {
      homeData.value = HomeModel();
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      homeData.value = HomeModel();
      print('error:$e');
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }

  RxInt currentSlider = 0.obs;
  updateCurrentSlider({required int newSlider}) {
    currentSlider.value = newSlider;
  }

  RxInt currentOffer = 0.obs;
  updateCurrentOffer({required int newSlider}) {
    currentOffer.value = newSlider;
  }

  RxInt currentSalesProducts = 0.obs;
  updateSalesProducts({required int newSlider}) {
    currentSalesProducts.value = newSlider;
  }

  addToCart(
      {required int productId,
      int? productOptionId,
      int? productParentId}) async {
    try {
      var context = Get.context;

      LoadingScreen.show(context!);

      await _api.addProductToCart(
          quantity: 1,
          productID: productId,
          productOptionID: productOptionId,
          optionID: productParentId);
      Get.back();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              height: 180.64.h,
              dilougText: tr('addedSuccessfully'),
              buttonOneText: tr('continuesShopping'),
              buttonTwoText: tr('continuesOrder'),
              onButtonTwoPressed: () {
                Get.to(CartScreen());
              },
            );
          });
      NavController.to.getCountOfCart();
    } on DioException catch (e) {
      Get.back();

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      Get.back();
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  addWishlist({required int postId}) async {
    await _api.addWishlistRequest(productId: postId);
  }

  removeWishlist({required int postId}) async {
    await _api.removeWishlistRequest(productId: postId);
    getWishlist();
  }

  RxBool isLoadingWishlist = false.obs;

  RxList wishlistList = [].obs;
  getWishlist() async {
    isLoadingWishlist.value = true;
    try {
      wishlistList.value = await _api.getTheWishlist();
    } on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoadingWishlist.value = false;
  }

  updateToLike(
      {bool? newArrivals,
      bool? salesProducts,
      bool? discover,
      required int index}) {
    if (newArrivals == true) {
      homeData.update((val) {
        val?.newArrivals?[index].wishlist?.add(ProductOptionsModel());
      });
      print(
          'newArrivals:${homeData.value.newArrivals?[index].wishlist?.length}');
    }
    if (salesProducts == true) {
      homeData.update((val) {
        val?.salesProducts?[index].wishlist?.add(ProductOptionsModel());
      });
      Future.delayed(const Duration(milliseconds: 500));
      print(
          'salesProducts:${homeData.value.salesProducts?[index].wishlist?.length}');
    }
    if (discover == true) {
      // homeData
      //     .value
      //     .discover
      //     ?.products?[index].wishlist?.add(ProductOptionsModel());
      homeData.update((val) {
        val?.discover?.products?[index].wishlist?.add(ProductOptionsModel());
      });
      print(
          'products:${homeData.value.discover?.products?[index].wishlist?.length}');
    }
  }
}
