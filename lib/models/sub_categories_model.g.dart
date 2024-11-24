// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] == null
          ? null
          : OfferImageModel.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image?.toJson(),
    };
