// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) => ReviewsModel(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      userId: json['user_id'] as int?,
      comment: json['comment'] as String?,
      rating: json['rating'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      dislikes: json['dislikes'] as int?,
      likes: json['likes'] as int?,
      isUserReacted: json['is_user_reacted'] as int?,
      user: _$JsonConverterFromJson<Map<String, dynamic>, UserModel>(
          json['user'], const UserModelJsonConv().fromJson),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => OfferImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsModelToJson(ReviewsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'user_id': instance.userId,
      'comment': instance.comment,
      'rating': instance.rating,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'dislikes': instance.dislikes,
      'likes': instance.likes,
      'is_user_reacted': instance.isUserReacted,
      'user': _$JsonConverterToJson<Map<String, dynamic>, UserModel>(
          instance.user, const UserModelJsonConv().toJson),
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
