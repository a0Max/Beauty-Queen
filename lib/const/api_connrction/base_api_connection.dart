import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

abstract class ApiProvider {
  //Singleton
  ApiProvider() {
    // Attach Interceptors.
    dio.interceptors.add(_performanceInterceptor);
    // if (kDebugMode) dio.interceptors.add(_logger);
  }

  // static final ApiProvider instance = ApiProvider._();

  // Http Client
  final Dio dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Performance Interceptor
  final _performanceInterceptor = DioFirebasePerformanceInterceptor();

  // Headers
  final Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json',
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  static const String loginEndPoint = "login";
  static const String addDeviceEndPoint = "storeDeviceToken";
  static const String registerEndPoint = "register";
  static const String sendVerificationCodeEndPoint = "sendVerificationCode";
  static const String checkCodeEndPoint = "checkCode";
  static const String getNewArrivalsEndPoint = "get/new-arrivals";
  static const String homepageEndPoint = "homepage";
  static const String getSalesEndPoint = "get/sales";
  static const String parentCategoriesPageEndPoint = "get/parentCategories";
  static const String getBrandsPageEndPoint = "get/brands";
  static const String getCartsPageEndPoint = "get/cart";
  static const String getQuickSearchEndPoint = "quickSearch";
  static const String userEndPoint = "user";
  static const String logoutEndPoint = "logout";
  static const String updatePasswordEndPoint = "updatePassword";
  static const String updateUserPasswordEndPoint = "updateUserPassword";
  static const String productEndPoint = "product";
  static const String addToCartProductEndPoint = "addToCart";
  static const String cartCounterProductEndPoint = "cartCounter";
  static const String changeQuantityProductEndPoint = "changeQuantity";
  static const String removeFromCartProductEndPoint = "removeFromCart";
  static const String submitReviewProductEndPoint = "submitReview";
  static const String addWishlistProductEndPoint = "add/wishlist";
  static const String getWishlistProductEndPoint = "get/wishlist";
  static const String removeWishlistProductEndPoint = "remove/wishlist";
  static const String getGiftsProductEndPoint = "get/gifts";
  static const String getSearchProductEndPoint = "search";
  static const String getOffersProductEndPoint = "get/offers";
  static const String getCategoryDataEndPoint = "category";
  static const String getCitiesDataEndPoint = "get/cities";
  static const String getNotificationsDataEndPoint = "get/notifications";
  static const String readNotificationsDataEndPoint = "readNotifications";
  static const String getAreasDataEndPoint = "get/areas";
  static const String updateUserPasswordDataEndPoint = "updateUserPassword";
  static const String updateUserDataDataEndPoint = "updateUserData";
  static const String getCategoryDataEndPoint2 = "get/category";
  static const String getCurrentCategoryChildrenDataEndPoint =
      "getCurrentCategoryChildren";
  static const String getQueenaProductsDataEndPoint = "get/queenaProducts";
  static const String getQueenaOffersDataEndPoint = "get/queenaOffers";
  static const String getAboutTheStoreDataEndPoint = "getAboutTheStore";
  static const String sendMessageDataEndPoint = "sendMessage";
  static const String getEventsDataEndPoint = "get/events";
  static const String getEventDataEndPoint = "get/event";
  static const String getReviewsDataEndPoint = "get/reviews";
  static const String submitReactionDataEndPoint = "submitReaction";
  static const String upgradeUserDataEndPoint = "upgradeUser";
  static const String confirmOrderDataEndPoint = "confirmOrder";
  static const String cancelOrderDataEndPoint = "cancelOrder";
  static const String getQueenaTransactionsDataEndPoint =
      "get/queenaTransactions";
  static const String checkPromoCodeDataEndPoint = "checkPromoCode";
  static const String getOrderDetailsDataEndPoint = "get/orderDetails";
  static const String getOrderHistoryDataEndPoint = "get/orderHistory";
  static const String getFAQDataEndPoint = "getFAQ";
  static const String checkGiftCardCodeDataEndPoint = "checkGiftCardCode";
  static const String socialGoogleDataEndPoint = "auth/social/google";
  static const String getCartDetailsDataEndPoint = "getCartDetails";
  static const String updateShippingCostDataEndPoint = "updateShippingCost";
  static const String storeCartDataEndPoint = "store/cart";
  static const String orderSummaryDataEndPoint = "orderSummary";
  static const String getWalletTransactionsDataEndPoint =
      "get/walletTransactions";

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(int statusCode) => statusCode >= 200 && statusCode < 300;

  // Getting User Token.
  Future<String?> getUserToken() async => await UserModel.getToken;

  setTheHeader(Headers headers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookies = (headers['set-cookie']?.first ?? '').split(";").first;
    print('#########################');
    headers.forEach((name, values) {
      print('$name - $values');
    });
    print('cookies:$cookies');
    print('#########################');
    prefs.setString('set-cookie', cookies);
  }

  getCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('set-cookie');
  }
////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// UTILS /////////////////////////////////////

  static Future<String> getAppLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String defaultLocale = Platform.localeName;
    if (prefs.getString('locale') == null) {
      if (defaultLocale.split('_')[0] != 'en' &&
          defaultLocale.split('_')[0] != 'ar') {
        return 'en';
      } else {
        return defaultLocale.split('_')[0];
      }
    } else {
      return prefs.getString('locale')!.split('_')[0];
    }
  }

  getCheckNetwork() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
