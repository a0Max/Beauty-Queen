// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CombinedController extends GetxController {
  var nameObscureText = false.obs;
  var phoneObscureText = false.obs;
  var passwordObscureText = true.obs;
  var confirmPasswordObscureText = true.obs;
  var loading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    passwordObscureText.value = !passwordObscureText.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordObscureText.value = !confirmPasswordObscureText.value;
  }

  Future<void> signUp() async {
    if (loading.value) return;
    loading.value = true;

    final response = await http.post(
      Uri.parse('https://beautyqueen.ly/api/v1/register'),
      body: {
        'name': nameController.text,
        'phone': phoneController.text,
        'password': passwordController.text,
        'password_confirmation': confirmPasswordController.text,
      },
    );

    if (response.statusCode == 200) {
    } else {}

    loading.value = false;
  }
}
