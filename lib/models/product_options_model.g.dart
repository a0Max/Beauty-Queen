// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionsModel _$ProductOptionsModelFromJson(Map<String, dynamic> json) =>
    ProductOptionsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      productId: json['product_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      category2: json['category2'] == null
          ? null
          : CategoryModel.fromJson(json['category2'] as Map<String, dynamic>),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductOptionsModelToJson(
        ProductOptionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'product_id': instance.productId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'category2': instance.category2?.toJson(),
    };
