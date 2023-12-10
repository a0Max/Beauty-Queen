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
      prices:
          (json['prices'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      'salesCount': instance.salesCount,
      'brands': instance.brands?.map((e) => e.toJson()).toList(),
      'prices': instance.prices,
      'labels': instance.labels?.map((e) => e.toJson()).toList(),
      'info': instance.info?.toJson(),
    };
