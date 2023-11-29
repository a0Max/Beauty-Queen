import 'dart:developer';

import 'package:beauty_queen/models/api_response_model.dart';
import 'package:beauty_queen/models/user_model.dart';
import 'package:beauty_queen/models/usermodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../View/bottom_nav_screen.dart';
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
    userData.value = await _api.signUpRequest(phone:phone, password:password);

  }
}
