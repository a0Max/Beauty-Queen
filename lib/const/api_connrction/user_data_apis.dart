import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';

import '../../models/user_model.dart';
import 'base_api_connection.dart';

class UserDataApis extends ApiProvider {

  Future<UserModel> loginRequest({String? phone, String? password}) async {
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.loginEndPoint}',
      queryParameters: {
        "phone": phone,
        "password": password,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    print(response.data);
    if (validResponse(response.statusCode!)) {
      return UserModel.fromMap(
        response.data,
      );
    } else {
      print(response.data);
      throw response.data;
    }
  }

  Future<UserModel> signUpRequest({String? phone, String? password}) async {
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.loginEndPoint}',
      queryParameters: {
        "phone": phone,
        "password": password,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    print(response.data);
    if (validResponse(response.statusCode!)) {
      return UserModel.fromMap(
        response.data,
      );
    } else {
      print(response.data);
      throw response.data;
    }
  }
}
