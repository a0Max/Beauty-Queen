
import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../models/city_area_model.dart';
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
    await setTheHeader(response.headers);
    if (validResponse(response.statusCode!)) {
      return UserModel.fromMap(
        response.data,
      );
    } else {
      throw response.data;
    }
  }

  Future<UserModel> signUpRequest(
      {String? name, String? phone, String? password}) async {
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.registerEndPoint}',
      queryParameters: {
        "phone": phone,
        "name": name,
        "password": password,
        "password_confirmation": password
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    await setTheHeader(response.headers);

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
      //sendVerificationCode
      final response = await dio.post(
        '${Connection.apiURL}${ApiProvider.sendVerificationCodeEndPoint}',
        queryParameters: {"phone": phone},
        options: Options(
          headers: {
            ...apiHeaders,
            'Accept-Language': await ApiProvider.getAppLanguage(),
            // 'Country-Id': await _getCountryCode(),
          },
        ),
      );
      await setTheHeader(response.headers);

      if (validResponse(response.statusCode!)) {
        return response.data.toString();
      } else {
        throw response.data;
      }
    } on DioException {
      throw tr('check_phone_number');
    } catch (e) {
      throw tr('check_phone_number');
    }
  }

  Future<bool> checkCodeRequest(
      {required String phone, required String sms}) async {
    final cookies = await getCookies();
    //checkCode
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.checkCodeEndPoint}',
      queryParameters: {"phone": phone, "code": sms},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      // forgetPasswordRequest(phone: phone, password: '01289555089', rePassword: '01289555089');
      return true;
    } else {
      throw response.data;
    }
  }

  Future<void> forgetPasswordRequest(
      {required String phone, required String password, required String rePassword}) async {
    //updatePassword
    final cookies = await getCookies();
    final response = await dio.post(
        '${Connection.apiURL}${ApiProvider.updatePasswordEndPoint}',
        queryParameters: {
          "phone": phone,
          "password": password,
          'password_confirmation': rePassword
        },
        options: Options(
          headers: {
            ...apiHeaders,
            'Accept-Language': await ApiProvider.getAppLanguage(),
            if (cookies != null) "Cookie": '$cookies',
            // 'Content-Type': "text/html; charset=UTF-8"
          },
        ),
      );
      if (validResponse(response.statusCode!)) {
      } else {
        throw response.data;
      }
  }

  Future<UserModel> userDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.userEndPoint}',
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
      final List<UserModel> l = [];
      response.data.forEach((e) => l.add(UserModel.fromMap(e)));
      return l.first;
    } else {
      throw response.data;
    }
  }

  Future<void> logoutUserRequest() async {
    final token = await getUserToken();
    await dio.post(
      '${Connection.apiURL}${ApiProvider.logoutEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
  }

  Future<List<CityAreaModel>> getCityDataRequest() async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getCitiesDataEndPoint}',
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
      final List<CityAreaModel> l = [];
      response.data['cities'].forEach((e) => l.add(CityAreaModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }

  Future<List<CityAreaModel>> getAreaDataRequest({required int cityId}) async {
    final token = await getUserToken();
    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getAreasDataEndPoint}/$cityId',
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
      final List<CityAreaModel> l = [];
      response.data['areas'].forEach((e) => l.add(CityAreaModel.fromJson(e)));
      return l;
    } else {
      throw response.data;
    }
  }


  Future<void> updatePasswordRequest(
      {required String currentPassword, required String newPassword, required String reNewPassword}) async {
    final cookies = await getCookies();
    final token = await getUserToken();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.updatePasswordEndPoint}',
      queryParameters: {
        "password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmations": reNewPassword
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',

          // 'Country-Id': await _getCountryCode(),
        },
      ),
    );
    await setTheHeader(response.headers);

    if (validResponse(response.statusCode!)) {

    } else {
      throw response.data;
    }
  }
}
