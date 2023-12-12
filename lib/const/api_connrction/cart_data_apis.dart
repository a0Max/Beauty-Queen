
import 'package:dio/dio.dart';

import '../../models/cart_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class CartDataApis extends ApiProvider {
  Future<CartModel> cartDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getCartsPageEndPoint}',
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
      return CartModel.fromJson(response.data);

    } else {
      throw response.data;
    }
  }


  Future changeQuantityDataRequest({required String productId, required int productQuantity}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.changeQuantityProductEndPoint}',
      queryParameters: {
        'id':productId,
        'quantity': productQuantity
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
      throw response.data;
    }
  }

  Future removeItemDataRequest({required String productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.removeFromCartProductEndPoint}',
      queryParameters: {
        'id':productId
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
      throw response.data;
    }
  }

}