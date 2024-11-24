import 'package:dio/dio.dart';

import '../../models/categories_model.dart';
import '../../models/general_search_model.dart';
import '../../models/get_category_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';
import 'package:quiver/strings.dart';

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
      response.data['categories']
          .forEach((e) => l.add(CategoryModel.fromJson(e)));
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
      response.data['categories']
          .forEach((e) => l.add(CategoryModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<GetCategoryModel> getChildDataRequest2({
    required int parentId,
    int? subId,
    required int page,
  }) async {
    final token = await getUserToken();
    final response = await dio.get(
      subId == null
          ? '${Connection.apiURL2}${ApiProvider.getCategoryDataEndPoint2}/$parentId/null'
          : '${Connection.apiURL2}${ApiProvider.getCategoryDataEndPoint2}/$parentId/$subId',
      queryParameters: {'page': page},
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
      return GetCategoryModel.fromJson(response.data);
    } else {
      throw response.data;
    }
  }

  Future<List<CategoryModel>> getChildDataRequest(
      {required int parentId}) async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getCurrentCategoryChildrenDataEndPoint}/$parentId',
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
      response.data['children']
          .forEach((e) => l.add(CategoryModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<GeneralSearchModel> getCategoryDataRequest(
      {String? keySort,
      List? selectedLabels,
      required int page,
      required int categoryId,
      int? subId,
      List? selectedPrices,
      List? selectedBrands}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final response = await dio.get(
      subId == null
          ? '${Connection.apiURL}${ApiProvider.getCategoryDataEndPoint}/$categoryId'
          : '${Connection.apiURL}${ApiProvider.getCategoryDataEndPoint}/$categoryId/$subId',
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
}
