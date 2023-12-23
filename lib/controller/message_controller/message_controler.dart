import 'dart:developer';

import 'package:beauty_queen/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View/home/bottom_nav_screen.dart';
import '../../View/welcome/welcome_screen.dart';
import '../../const/api_connrction/app_data_apis.dart';
import '../../const/api_connrction/brands_data_api.dart';
import '../../const/api_connrction/user_data_apis.dart';
import '../../models/brand_model.dart';
import '../../models/city_area_model.dart';
import '../../widgets/based/error_pop_up.dart';

class MessageController extends GetxController {
  final _api = AppDataApis();

  sendMessageToManagies(
      {required String phone, required String message}) async {
    await _api.sendMessageRequest(phone: phone, message: message);
  }
}
