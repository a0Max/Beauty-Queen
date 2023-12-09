import 'package:dio/dio.dart';

import '../../models/home_model.dart';
import '../../models/product_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class ProductDataApis extends ApiProvider {
  Future<ProductModel> getProductDataRequest({required int productId}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final response = await dio.get(
      ///todo back it
      // '${Connection.apiURL}${ApiProvider.productEndPoint}/$productId',
      '${Connection.apiURL}${ApiProvider.productEndPoint}/3367',
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
    await setTheHeader(response.headers);

    if (validResponse(response.statusCode!)) {
      return ProductModel.fromJson(

        response.data,
      );
    } else {
      throw response.data;
    }
  }

}