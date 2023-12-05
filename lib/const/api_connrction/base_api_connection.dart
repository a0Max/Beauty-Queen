import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import '../vars.dart';


abstract class ApiProvider {
  //Singleton
  ApiProvider() {
    // Attach Interceptors.
    dio.interceptors.add(_performanceInterceptor);
    if (kDebugMode) dio.interceptors.add(_logger);
  }

  // static final ApiProvider instance = ApiProvider._();

  // Http Client
  final Dio dio = Dio();

  // Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    requestHeader: true,
    error: true,
  );

  // Performance Interceptor
  final _performanceInterceptor = DioFirebasePerformanceInterceptor();

  // Headers
  final Map<String, dynamic> apiHeaders = <String, dynamic>{
    'Accept': 'application/json',
  };

  ////////////////////////////// END POINTS ///////////////////////////////////
  static const String loginEndPoint = "login";
  static const String registerEndPoint = "register";
  static const String sendVerificationCodeEndPoint = "sendVerificationCode";
  static const String checkCodeEndPoint = "checkCode";
  static const String homepageEndPoint = "homepage";
  static const String userEndPoint = "user";
  static const String logoutEndPoint = "logout";
  static const String updatePasswordEndPoint = "updatePassword";

////////////////////////////////////////////////////////////////////////////

  // Validating Request.
  bool validResponse(int statusCode) => statusCode >= 200 && statusCode < 300;

  // Getting User Token.
  Future<String?> getUserToken() async => await UserModel.getToken;


////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////// UTILS /////////////////////////////////////


  static Future<String> getAppLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String defaultLocale = Platform.localeName;
    if (prefs.getString('locale') == null) {
      if (defaultLocale.split('_')[0] != 'en' &&
          defaultLocale.split('_')[0] != 'ar') {
        return 'en';
      } else {
        return defaultLocale.split('_')[0];
      }
    } else {
      return prefs.getString('locale')!.split('_')[0];
    }
  }


}

