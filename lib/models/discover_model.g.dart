// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverModel _$DiscoverModelFromJson(Map<String, dynamic> json) =>
    DiscoverModel(
      info: json['info'] == null
          ? null
          : SlidesModel.fromJson(json['info'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscoverModelToJson(DiscoverModel instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };
