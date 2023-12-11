// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralSearchModel _$GeneralSearchModelFromJson(Map<String, dynamic> json) =>
    GeneralSearchModel(
      sales: json['sales'] == null
          ? null
          : PaginationModel.fromJson(json['sales'] as Map<String, dynamic>),
      salesCount: json['salesCount'] as int?,
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      gifts: json['gifts'] == null
          ? null
          : PaginationModel.fromJson(json['gifts'] as Map<String, dynamic>),
      prices:
          (json['prices'] as List<dynamic>?)?.map((e) => e as String).toList(),
      brand: json['brand'] == null
          ? null
          : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      products: json['products'] == null
          ? null
          : PaginationModel.fromJson(json['products'] as Map<String, dynamic>),
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] == null
          ? null
          : ProductBanner.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralSearchModelToJson(GeneralSearchModel instance) =>
    <String, dynamic>{
      'sales': instance.sales?.toJson(),
      'products': instance.products?.toJson(),
      'gifts': instance.gifts?.toJson(),
      'salesCount': instance.salesCount,
      'brands': instance.brands?.map((e) => e.toJson()).toList(),
      'brand': instance.brand?.toJson(),
      'prices': instance.prices,
      'labels': instance.labels?.map((e) => e.toJson()).toList(),
      'info': instance.info?.toJson(),
    };
