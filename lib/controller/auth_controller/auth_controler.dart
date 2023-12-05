import 'dart:developer';

import 'package:beauty_queen/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../View/home/bottom_nav_screen.dart';
import '../../View/welcome_screen.dart';
import '../../const/api_connrction/user_data_apis.dart';
import '../../widgets/error_pop_up.dart';
import '../../widgets/loading.dart';

class AuthController extends GetxController {
  var obscureText = true.obs;
  var userData = UserModel().obs;
  final _api = UserDataApis();

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  login(String phone, String password) async {
    userData.value = await _api.loginRequest(phone:phone, password:password);
    getUserData();
  }

  var passwordObscureText = true.obs;
  var confirmPasswordObscureText = true.obs;


  void toggleSignUpPasswordVisibility() {
    passwordObscureText.value = !passwordObscureText.value;
  }

  void toggleSignUpConfirmPasswordVisibility() {
    confirmPasswordObscureText.value = !confirmPasswordObscureText.value;
  }

  Future<void> signUp({required String phone, required String password, required String name, required String rePassword}) async {
    userData.value = await _api.signUpRequest(phone:phone, password:password, name:name);
    getUserData();
  }

  Future<void> updatePassword({required String phone, required String password, required String rePassword}) async {
    try{
    await _api.forgetPasswordRequest(phone:phone, password:password, rePassword:rePassword);
    } on DioError catch (e, s) {

      ErrorPopUp(message: (e.response?.data as Map).values.first, title: 'خطا');

    } catch (e, s) {
      ErrorPopUp(message: tr('something_wrong'), title: 'خطا');

    }
  }

  var progressValue = 0.0.obs;
  var showProgress = true.obs;

  void startProgress() async {
    while (progressValue.value < 1.0) {
      await Future.delayed(const Duration(milliseconds: 25));
      progressValue.value += 0.01;
      if(progressValue.value == 0.01) {
        try {
          await getUserData();
        }catch(e){
          log('Error:$e');
        }
      }
    }
    showProgress.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
    if (userData.value.id!=null){
      Get.off(() => const MainView());
    }else {
      Get.off(() => const WelcomeScreen());
    }
  }

  getUserData() async {
    userData.value = await _api.userDataRequest();
  }

  logoutUserData() async {
    _api.logoutUserRequest();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    userData.value = UserModel();
  }
}
