// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CombinedController extends GetxController {
  var passwordObscureText = true.obs;
  var confirmPasswordObscureText = true.obs;


  void togglePasswordVisibility() {
    passwordObscureText.value = !passwordObscureText.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordObscureText.value = !confirmPasswordObscureText.value;
  }

  Future<void> signUp() async {
    // userData.value = await _api.login(phone:phone, password:password);

  }
}
