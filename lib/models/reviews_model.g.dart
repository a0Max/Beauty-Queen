// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsModel _$ReviewsModelFromJson(Map<String, dynamic> json) => ReviewsModel(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      dislikes: (json['dislikes'] as num?)?.toInt(),
      likes: (json['likes'] as num?)?.toInt(),
      isUserReacted: (json['is_user_reacted'] as num?)?.toInt(),
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
