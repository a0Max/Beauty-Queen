// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCategoryModel _$GetCategoryModelFromJson(Map<String, dynamic> json) =>
    GetCategoryModel(
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCategoryModelToJson(GetCategoryModel instance) =>
    <String, dynamic>{
      'category': instance.category?.toJson(),
      'parents': instance.parents?.map((e) => e.toJson()).toList(),
    };
