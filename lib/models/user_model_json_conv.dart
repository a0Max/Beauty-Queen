import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

class UserModelJsonConv extends JsonConverter<UserModel, Map<String, dynamic>> {
  const UserModelJsonConv();

  @override
  UserModel fromJson(Map<String, dynamic>? json) =>
      UserModel.fromMap(json ?? {});

  @override
  Map<String, dynamic> toJson(UserModel object) {
    return <String, dynamic>{};
  }
}
