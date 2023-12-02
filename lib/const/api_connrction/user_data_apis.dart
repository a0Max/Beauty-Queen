import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

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
    if (validResponse(response.statusCode!)) {
      return UserModel.fromMap(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  Future<UserModel> signUpRequest({String? name, String? phone, String? password}) async {
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.registerEndPoint}',
      queryParameters: {
        "phone": phone,
        "name": name,
        "password": password,
        "password_confirmation":password
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      return UserModel.fromMap(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  Future<String> sendVerificationCodeRequest({required String phone}) async {
    final token = await getUserToken();
    try {
      final response = await dio.post(
        '${Connection.apiURL}${ApiProvider.sendVerificationCodeEndPoint}',
        queryParameters: {"phone": phone},
        options: Options(
          headers: {
            ...apiHeaders,
            'Accept-Language': await ApiProvider.getAppLanguage(),
            "Authorization": 'Bearer $token',
            // 'Country-Id': await _getCountryCode(),
          },
        ),
      );
      if (validResponse(response.statusCode!)) {
        return response.data.toString();
      }
      else {
        throw response.data;
      }
    } on DioException catch (e, s) {
      throw tr('check_phone_number');
    } catch (e) {
      throw tr('check_phone_number');
    }
  }

  Future<bool> checkCodeRequest(
      {required String phone, required String sms}) async {
    final token = await getUserToken();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.checkCodeEndPoint}',
      queryParameters: {"phone": phone, "code": sms},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          "Authorization": 'Bearer $token',
          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      return true;
    } else {
      throw response.data;
    }
  }
}
