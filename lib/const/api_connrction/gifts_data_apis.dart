import 'package:dio/dio.dart';

import '../../models/general_search_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';
import 'package:quiver/strings.dart';

class GiftsDataApis extends ApiProvider {


  Future<GeneralSearchModel> getGiftsDataRequest(
      {String? keySort,
        List? selectedLabels,
        required int page,
        List? selectedPrices,
        List? selectedBrands}) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getGiftsProductEndPoint}',
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
}