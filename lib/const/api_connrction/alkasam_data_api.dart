
import 'package:dio/dio.dart';

import '../../models/categories_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class AlkasamDataApis extends ApiProvider {
  Future<List<CategoryModel>> categoryDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.parentCategoriesPageEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',

        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      final List<CategoryModel> l = [];
      response.data['categories'].forEach((e) => l.add(CategoryModel.fromJson(e)));
      print('l:${l.length}');
      return l;

    } else {
      throw response.data;
    }
  }
  Future<List<CategoryModel>> addDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.parentCategoriesPageEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',

        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      final List<CategoryModel> l = [];
      response.data['categories'].forEach((e) => l.add(CategoryModel.fromJson(e)));
      print('l:${l.length}');
      return l;

    } else {
      throw response.data;
    }
  }
}