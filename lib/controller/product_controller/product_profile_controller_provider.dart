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
export 'package:provider/provider.dart';

class ProductProfileControllerProvider extends ChangeNotifier {
  final _api = HomeDataApis();
  bool isLoading = false;
  List productData = [];

  getCurrentProduct({required int productId}) async {
    try {
      isLoading = true;
      notifyListeners();

      ProductModel newData =
          await _api.getProductDataRequest(productId: productId);
      selectedOptions =
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
    isLoading = false;
    notifyListeners();
  }

  getAllReviewsOfProduct({required int productId}) async {
    List<ReviewsModel>? reviewsData =
        await _api.getReviewsData(productId: productId.toString());
    if (reviewsData.isNotEmpty) {
      print('reviewsData:$reviewsData');
      (productData.last.reviews = reviewsData);
      notifyListeners();
    }
  }

  removeLastAll() async {
    // if (isLoading != true) {
    //   // if (productData.isNotEmpty) {
    //   productData.removeLast();
    //
    //   selectedOptions = List.generate(
    //       productData.last.productOptions?.length ?? 0, (index) => null);
    //   notifyListeners();
    // }
    // // await selectedOptions.clear();
    //
    // await Future.delayed(const Duration(milliseconds: 500));
    //
    // print('productData:${productData.last.id}');
    // log('productData:${productData.last.id}');
    // notifyListeners();
  }

  List selectedOptions = [];
  updateToSelected({required int index, required OptionsModel? selected}) {
    selectedOptions.insert(index, selected);
    selectedOptions.removeAt(index + 1);
    notifyListeners();
  }

  var selectedSliderIndex = 0;
  void changeSliderIndex(int index) {
    selectedSliderIndex = index;
    notifyListeners();
  }

  var count = 1;
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
    if (productData.last.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.first == null) {
        chooseFirst();
      } else if (int.parse(selectedOptions.first.stock) > count) {
        count++;
        notifyListeners();
      } else {
        arrivedToMax();
      }
    } else {
      if (int.parse(productData.last.product?.stock ?? '1') > count) {
        count++;
        notifyListeners();
      } else {
        arrivedToMax();
      }
    }
    notifyListeners();
  }

  void decrement() {
    if (productData.last.productOptions?.isNotEmpty ?? false) {
      if (selectedOptions.first == null) {
        chooseFirst();
      } else if (count > 1) {
        count--;
      } else {
        arrivedToMin();
      }
    } else {
      if (count > 1) {
        count--;
        notifyListeners();
      } else {
        arrivedToMin();
      }
    }
  }

  addToCart() async {
    try {
      if (productData.last.productOptions?.isNotEmpty ?? false) {
        for (dynamic selected in selectedOptions) {
          if (selected == null) {
            chooseFirst();
            return;
          }
        }
        await _api.addProductToCart(
            quantity: count,
            productID: productData.last.product?.id ?? 0,
            productOptionID: productData.last.productOptions?.first.id,
            optionID: selectedOptions.first.id);
      } else if (selectedOptions.isEmpty) {
        await _api.addProductToCart(
            quantity: count, productID: productData.last.product?.id ?? 0);
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

  String imagePath = '';
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return;
    } else {
      imagePath = response.path;
      notifyListeners();
    }
  }

  clearImage() {
    imagePath = '';
    notifyListeners();
  }

  int rate = 0;
  currentRate({required int newRate}) {
    rate = newRate;
    notifyListeners();
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
        productId: "${productData.last.product?.id ?? 0}",
        image: imagePath);
  }

  clearData() {
    rate = 0;
    imagePath = '';
    notifyListeners();
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
        productId: int.parse("${productData.last?.product?.id ?? 0}"));
  }

  addDisLikeReaction({required String productId}) async {
    await _api.addReaction(
        productId: productId, reactionCode: ReactionCode.disLike);
    await getAllReviewsOfProduct(
        productId: int.parse("${productData.last?.product?.id ?? 0}"));
  }

  addWishlist({required int postId}) async {
    await _api.addWishlistRequest(productId: postId);
  }
}
