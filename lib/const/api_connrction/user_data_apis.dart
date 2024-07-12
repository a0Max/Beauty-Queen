import 'package:beauty_queen/const/vars.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../models/city_area_model.dart';
import '../../models/user_model.dart';
import 'base_api_connection.dart';

class UserDataApis extends ApiProvider {
  Future<String?> _getFirebaseToken() async =>
      await FirebaseMessaging.instance.getToken().catchError((e) => null);

  Future<void> addDevice() async {
    print('addDevice');
    final token = await getUserToken();
    await FirebaseMessaging.instance.subscribeToTopic("all_users");
    final fbToken = await _getFirebaseToken();
    print("$fbToken");
    print("####################");
    if (fbToken == null) return;

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.addDeviceEndPoint}',
      queryParameters: {'token': fbToken},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // 'Country-Id': await _getCountryCode(),
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (validResponse(response.statusCode!)) {
      //ok
      // return UserModel.fromMap(
      //   response.data['user'],
      //   token: response.data['token'],
      // );
    } else {
      // Err
      throw response.data;
    }
  }

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
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
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
      {required String phone,
      required String password,
      required String rePassword}) async {
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
    final cookies = await getCookies();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.userEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
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

  Future<void> deleteUserRequest() async {
    final token = await getUserToken();
    await dio.post(
      '${Connection.apiURL}${ApiProvider.deleteEndPoint}',
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

  Future<bool> updateUserRequest({
    required String name,
    required String lastName,
    required String? birthDate,
    required String phone,
    required String? cityId,
    required String? areaId,
    required String? phone2,
    required String? email,
    required String? whatsappPhone,
    required String? brand1,
    required String? brand2,
    required String? brand3,
  }) async {
    final token = await getUserToken();
    final cookies = await getCookies();
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.updateUserDataDataEndPoint}',
      queryParameters: {
        'name': name,
        'last_name': lastName,
        'birth_date': birthDate,
        'phone': phone,
        'city_id': cityId,
        'area_id': areaId,
        'phone2': phone2,
        'email': email,
        'whatsapp_phone': whatsappPhone,
        'brand1': brand1,
        'brand2': brand2,
        'brand3': brand3,
      },
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
          if (token != null) "Authorization": 'Bearer $token',
        },
      ),
    );
    if (validResponse(response.statusCode!)) {
      return true;
    } else {
      throw response.data;
    }
  }
  // Future<List<CityAreaModel>> getCityDataRequest() async {
  //   final token =
  //       "\$2y\$10\$PPmVhaAgGfx0udZ8SncFweHXTBJfvaGJkr.No4W5KyV/oGSMwbv.q";
  //   // final cookies = await getCookies();
  //
  //   final response = await dio.get(
  //     'https://test.kafiil.com/api/test/user/who-am-i',
  //     options: Options(
  //       headers: {
  //         // 'Host': 'test.kafiil.com',
  //         'Accept-Language': 'ar',
  //         ...apiHeaders,
  //         "Authorization": '$token',
  //       },
  //     ),
  //   );
  //   if (validResponse(response.statusCode!)) {
  //     final List<CityAreaModel> l = [];
  //     response.data['cities'].forEach((e) => l.add(CityAreaModel.fromJson(e)));
  //     return l;
  //   } else {
  //     throw response.data;
  //   }
  // }

  Future<List<CityAreaModel>> getCityDataRequest() async {
    final token = await getUserToken();
    final cookies = await getCookies();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getCitiesDataEndPoint}',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
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
    final cookies = await getCookies();

    final response = await dio.get(
      '${Connection.apiURL}${ApiProvider.getAreasDataEndPoint}/$cityId',
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          if (cookies != null) "Cookie": '$cookies',
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
      {required String currentPassword,
      required String newPassword,
      required String reNewPassword}) async {
    final cookies = await getCookies();
    final token = await getUserToken();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.updateUserPasswordEndPoint}',
      queryParameters: {
        "password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": reNewPassword
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

  Future<void> upgradeUserStateRequest() async {
    final cookies = await getCookies();
    final token = await getUserToken();

    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.upgradeUserDataEndPoint}',
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

  Future<UserModel> sendRequestOfGoogleLogin(
      {required String googleId,
      required String email,
      required String? name}) async {
    // final token = await getUserToken();
    // final cookies = await getCookies();
    final response = await dio.post(
      '${Connection.apiURL}${ApiProvider.socialGoogleDataEndPoint}',
      queryParameters: {'name': name, 'google_id': googleId, 'email': email},
      options: Options(
        headers: {
          ...apiHeaders,
          'Accept-Language': await ApiProvider.getAppLanguage(),
          // if (cookies != null) "Cookie": '$cookies',
          // if (token != null) "Authorization": 'Bearer $token',
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
}
