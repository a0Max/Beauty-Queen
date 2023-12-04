import 'package:dio/dio.dart';

import '../../models/home_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

class HomeDataApis extends ApiProvider {
  Future<HomeModel> homeDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.homepageEndPoint}',
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
      return HomeModel.fromJson(

        response.data,
      );
    } else {
      throw response.data;
    }
  }

}