import 'dart:developer';

import 'package:beauty_queen/models/api_response_model.dart';
import 'package:beauty_queen/models/usermodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInController extends GetxController {
  var obscureText = true.obs;
  var user = User().obs;
  var token = ''.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login(String phone, String password) async {
    final Uri url = Uri.parse(
        'https://beautyqueen.ly/api/v1/login?phone=$phone&password=$password');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        ApiResponse apiResponse = ApiResponse.fromJson(jsonResponse);
        user.value = apiResponse.user;
        token.value = apiResponse.token;
      } else {
        // Handle non-200 status codes
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle network errors
      log('Network error: $e');
    }
  }
}
