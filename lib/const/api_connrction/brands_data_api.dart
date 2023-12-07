
import 'package:dio/dio.dart';

import '../../models/brand_model.dart';
import '../../models/categories_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class BrandsDataApis extends ApiProvider {
  Future<List<BrandModel>> breandsDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getBrandsPageEndPoint}',
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
      final List<BrandModel> l = [];
      response.data['brands'].forEach((e) => l.add(BrandModel.fromJson(e)));
      print('l:${l.length}');
      return l;

    } else {
      throw response.data;
    }
  }}