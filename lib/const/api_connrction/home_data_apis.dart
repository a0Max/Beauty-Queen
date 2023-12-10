import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/general_search_model.dart';
import '../../models/home_model.dart';
import '../../models/product_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';
import 'package:quiver/strings.dart';

class HomeDataApis extends ApiProvider {
  Future<HomeModel> homeDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
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

  Future<int> getCartRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();
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
      print('count:$count');
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
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getSalesEndPoint}',
      queryParameters: {
        if (isBlank(keySort)==false) 'sort': keySort,
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

  addReview({
    required String comment,
    int? rating,
    String? image,
    required String productId
    }) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    File file = File(image.toString());
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      if(isBlank(rating.toString())==false)'rating': rating,
      'product_id': productId,
      'comment': comment,
      if (image != null)
        "images": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.submitReviewProductEndPoint}',
      queryParameters: {

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
      int count = response.data['counter'];
      print('count:$count');
      return count;
    } else {
      throw 0;
    }
  }
}
