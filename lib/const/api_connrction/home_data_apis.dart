import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../models/general_search_model.dart';
import '../../models/home_model.dart';
import '../../models/product_model.dart';
import '../../models/product_options_model.dart';
import '../../models/reviews_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';
import 'package:quiver/strings.dart';

class HomeDataApis extends ApiProvider {
  Future<HomeModel> homeDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.homepageEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      return HomeModel.fromJson(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  Future<ProductModel> getProductDataRequest({required int productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.productEndPoint}/$productId',
      // '${Connection.apiURL}${ApiProvider.productEndPoint}/3367',
      // '${Connection.apiURL}${ApiProvider.productEndPoint}/3029',

      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    // await setTheHeader(response.headers);

    if (validResponse(response.statusCode!)) {
      return ProductModel.fromJson(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  Future<bool> addProductToCart(
      {required int quantity,
      required int productID,
      int? productOptionID,
      int? optionID}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.addToCartProductEndPoint}',
      queryParameters: {
        'productID': productID,
        'quantity': quantity,
        if (productOptionID != null) 'productOptionID': productOptionID,
        if (optionID != null) 'optionID': optionID
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    // await setTheHeader(response.headers);
    // getCartRequest();

    if (validResponse(response.statusCode!)) {
      return true;
    } else {
      throw response.data;
    }
  }

  Future<List<ReviewsModel>> getReviewsData({required String productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getReviewsDataEndPoint}/$productId',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // if (token != null) "Authorization": 'Bearer $token',
          // if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      final List<ReviewsModel> l = [];
      response.data['reviews'].forEach((e) => l.add(ReviewsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  addReaction({required String productId, required String reactionCode}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.submitReactionDataEndPoint}',
      queryParameters: {
        'id': productId,
        'reaction': reactionCode,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      // int count = response.data['counter'];
      // return count;
    } else {
      throw 0;
    }
  }

  Future<int> getCartRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.cartCounterProductEndPoint}',
      // '${Connection.apiURL}${ApiProvider.productEndPoint}/3367',
      // '${Connection.apiURL}${ApiProvider.productEndPoint}/3029',

      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      int count = response.data['counter'];
      return count;
    } else {
      throw 0;
    }
  }

  Future<GeneralSearchModel> getSalesDataRequest(
      {String? keySort,
      List? selectedLabels,
      required int page,
      List? selectedPrices,
      List? selectedBrands}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getSalesEndPoint}',
      queryParameters: {
        if (isBlank(keySort) == false) 'sort': keySort,
        if (selectedLabels?.isNotEmpty ?? false) 'label[]': selectedLabels,
        if (selectedPrices?.isNotEmpty ?? false) 'price[]': selectedPrices,
        if (selectedBrands?.isNotEmpty ?? false) 'brands[]': selectedBrands,
        'page': page
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      return GeneralSearchModel.fromJson(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  addReview(
      {required String comment,
      int? rating,
      String? image,
      required String productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }

    MultipartFile? images2;
    if (image != null) {
      File imageFile = File(image.toString());
      images2 = await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      );
    }

    FormData formData = FormData.fromMap({
      if (rating != null) 'rating': rating,
      'product_id': productId,
      'comment': comment,
      if (image != null) "images[]": images2
    });

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.submitReviewProductEndPoint}',
      data: formData,
      options: Options(
        headers: {
          ...apiHeaders,
          'Content-Type': 'multipart/form-data',
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      // int count = response.data['counter'];
      // return count;
    } else {
      throw 0;
    }
  }

  addWishlistRequest({required int productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.addWishlistProductEndPoint}',
      queryParameters: {
        'id': productId,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
    } else {
      throw 0;
    }
  }

  removeWishlistRequest({required int productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.removeWishlistProductEndPoint}',
      queryParameters: {
        'id': productId,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
    } else {
      throw 0;
    }
  }

  Future<List<ProductOptionsModel>> getTheWishlist() async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final checkNetwork = await getCheckNetwork();
    if (checkNetwork == false) {
      throw 'Check Network connection';
    }
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getWishlistProductEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      final List<ProductOptionsModel> l = [];
      response.data['items']
          .forEach((e) => l.add(ProductOptionsModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }
}
