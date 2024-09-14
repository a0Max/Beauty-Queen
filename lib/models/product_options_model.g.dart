// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionsModel _$ProductOptionsModelFromJson(Map<String, dynamic> json) =>
    ProductOptionsModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      productId: (json['product_id'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : SalesProductsModel.fromJson(
              json['product'] as Map<String, dynamic>),
      isColor: json['is_color'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
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
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'is_color': instance.isColor,
      'updated_at': instance.updatedAt,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'product': instance.product?.toJson(),
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'category2': instance.category2?.toJson(),
    };
