///TODO: need to delete it
import 'package:beauty_queen/models/usermodel.dart';

class ApiResponse {
  final User user;
  final String token;

  ApiResponse({required this.user, required this.token});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      user: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}
