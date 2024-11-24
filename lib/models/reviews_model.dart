import 'package:json_annotation/json_annotation.dart';

import 'offer_image_model.dart';
import 'user_model_json_conv.dart';
import 'user_model.dart';

part 'reviews_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ReviewsModel {
  int? id;
  int? productId;
  int? userId;
  String? comment;
  int? rating;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? dislikes;
  int? likes;
  int? isUserReacted;
  @UserModelJsonConv()
  UserModel? user;
  List<OfferImageModel>? images;

  ReviewsModel(
      {this.id,
      this.productId,
      this.userId,
      this.comment,
      this.rating,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.dislikes,
      this.likes,
      this.isUserReacted,
      this.user,
      this.images});

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return _$ReviewsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewsModelToJson(this);
}
