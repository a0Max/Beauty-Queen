import 'package:dio/dio.dart';

import '../../models/home_model.dart';
import '../vars.dart';
import 'base_api_connection.dart';

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
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
          if (cookies != null) "Cookie": '$cookies',

        },
      ),
    );
    await setTheHeader(response.headers);

    // final response2 = await dio.post(
    //   'https://beautyqueen.ly/api/v1/addToCart?productID=3372&productOptionID&optionID&quantity=1',
    //   options: Options(
    //     headers: {
    //       ...apiHeaders,
    //       'Accept-Language': await ApiProvider.getAppLanguage(),
    //       // 'Country-Id': await _getCountryCode(),
    //       if (token != null) "Authorization": 'Bearer $token',
    //
    //     },
    //   ),
    // );
    // final response3 = await dio.get(
    //   'https://beautyqueen.ly/api/v1/get/cart',
    //   options: Options(
    //     headers: {
    //       ...apiHeaders,
    //       'Accept-Language': await ApiProvider.getAppLanguage(),
    //       // 'Country-Id': await _getCountryCode(),
    //       if (token != null) "Authorization": 'Bearer $token',
    //
    //     },
    //   ),
    // );

    if (validResponse(response.statusCode!)) {
      return HomeModel.fromJson(

        response.data,
      );
    } else {
      throw response.data;
    }
  }

}