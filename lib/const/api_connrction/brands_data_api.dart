import 'package:dio/dio.dart';

import '../../models/brand_model.dart';
import 'package:quiver/strings.dart';
import '../../models/general_search_model.dart';
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
  }

  Future<GeneralSearchModel> getDetailOfBrandsDataRequest({required int id, required int page,String? keySort,
    List? selectedLabels,
    List? selectedPrices,
    List? selectedBrands}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getBrandsPageEndPoint}/$id',
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
          // 'Country-Id': await _getCountryCode(),
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
