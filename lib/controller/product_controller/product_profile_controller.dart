// ignore_for_file: file_names
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../View/cart/cart_screen.dart';
import '../../const/api_connrction/home_data_apis.dart';
import '../../const/vars.dart';
import '../../models/options_model.dart';
import '../../models/product_model.dart';
import '../../models/product_options_model.dart';
import '../../models/reviews_model.dart';
import '../../widgets/product_profile/CustomAlertBox.dart';
import '../../widgets/based/error_pop_up.dart';

class ProductProfileController extends GetxController {
  TabController? tabsController;
  var index = 0.obs;
  final _api = HomeDataApis();
  RxBool isLoading = false.obs;
  RxList productData = [].obs;

  @override
  void onClose() {
    tabsController!.dispose();
    super.onClose();
  }

  getCurrentProduct({required int productId}) async {
    try {
      isLoading.value = true;
      ProductModel newData =
          await _api.getProductDataRequest(productId: productId);
      selectedOptions.value =
          List.generate(newData.productOptions?.length ?? 0, (index) => null);
      await Future.delayed(const Duration(milliseconds: 500));
      productData.add(newData);
      await getAllReviewsOfProduct(productId: productId);
    } on DioException catch (e) {
      print('error:$e');
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      print('error:$e');
      if (e == 'Check Network connection') {
        ErrorPopUp(message: tr('network_connection'), title: 'خطا');
      } else {
        ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
      }
    }
    isLoading.value = false;
  }

  getAllReviewsOfProduct({required int productId}) async {
    List<ReviewsModel>? reviewsData =
        await _api.getReviewsData(productId: productId.toString());
    if (reviewsData != null && reviewsData.isNotEmpty) {
      print('reviewsData:$reviewsData');
      (productData.last.reviews = reviewsData);
      update();
    }
  }

  removeLast() async {
    if (productData.isNotEmpty) {
      productData.removeLast();
    }
    // await selectedOptions.clear();

    selectedOptions.value = List.generate(
        productData.last.productOptions?.length ?? 0, (index) => null);
    await Future.delayed(const Duration(milliseconds: 500));
    update();
  }

  RxList selectedOptions = [].obs;
  updateToSelected({required int index, required OptionsModel? selected}) {
    selectedOptions.insert(index, selected);
    selectedOptions.removeAt(index + 1);
  }

  var selectedSliderIndex = 0.obs;
  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
  }

  var count = 1.obs;
  chooseFirst() {
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

  void increment() {
    if (productData.value.last.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.value.first == null) {
        chooseFirst();
      } else if (int.parse(selectedOptions.first.stock) > count.value) {
        count.value++;
      } else {
        arrivedToMax();
      }
    } else {
      if (int.parse(productData.value.last.product?.stock ?? '1') >
          count.value) {
        count.value++;
      } else {
        arrivedToMax();
      }
    }
  }

  void decrement() {
    if (productData.value.last.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.value.first == null) {
        chooseFirst();
      } else if (count.value > 1) {
        count.value--;
      } else {
        arrivedToMin();
      }
    } else {
      if (count.value > 1) {
        count.value--;
      } else {
        arrivedToMin();
      }
    }
  }

  addToCart() async {
    try {
      if (productData.value.last.productOptions?.isNotEmpty ?? false) {
        for (dynamic selected in selectedOptions) {
          if (selected == null) {
            chooseFirst();
            return;
          }
        }
        await _api.addProductToCart(
            quantity: count.value,
            productID: productData.value.last.product?.id ?? 0,
            productOptionID: productData.value.last.productOptions?.first.id,
            optionID: selectedOptions.value.first.id);
      } else if (selectedOptions.value.isEmpty) {
        await _api.addProductToCart(
            quantity: count.value,
            productID: productData.value.last.product?.id ?? 0);
      }
      var context = Get.context;

      showDialog(
          context: context!,
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
    } on DioException catch (e) {
      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');
    } catch (e) {
      log('addToCart:error:$e');
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');
    }
  }

  RxString imagePath = ''.obs;
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    } else {
      imagePath.value = response.path;
    }
  }

  clearImage() {
    imagePath = ''.obs;
  }

  RxInt rate = 0.obs;
  currentRate({required int newRate}) {
    rate.value = newRate;
  }

  showCompleteComment() {
    var context = Get.context;

    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return CustomAlertDialog(
            buttonTwo: false,
            height: 172.29.h,
            width: 339.97.w,
            dilougText:
                'تم ارسال تقييمك بنجاح. سيتم نشره حال موافقة مسؤولين المتجر عليه',
            buttonOneText: 'حسناً',
          );
        });
  }

  verifyToAddReview({required String comment}) async {
    await _api.addReview(
        comment: comment,
        productId: "${productData.value.last.product?.id ?? 0}",
        image: imagePath.value);
  }

  clearData() {
    rate.value = 0;
    imagePath.value = '';
  }

  updateToLike({required int index}) {
    productData.last.update((val) {
      val?.p?[index].wishlist?.add(ProductOptionsModel());
    });
  }

  addLikeReaction({required String productId}) async {
    await _api.addReaction(
        productId: productId, reactionCode: ReactionCode.like);
    await getAllReviewsOfProduct(
        productId: int.parse("${productData.value.last?.product?.id ?? 0}"));
  }

  addDisLikeReaction({required String productId}) async {
    await _api.addReaction(
        productId: productId, reactionCode: ReactionCode.disLike);
    await getAllReviewsOfProduct(
        productId: int.parse("${productData.value.last?.product?.id ?? 0}"));
  }

  addWishlist({required int postId}) async {
    await _api.addWishlistRequest(productId: postId);
  }
}
