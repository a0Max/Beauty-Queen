// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityAreaModel _$CityAreaModelFromJson(Map<String, dynamic> json) =>
    CityAreaModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hasArea: json['has_area'] as String?,
      shippingCost: json['shipping_cost'],
      shippingTime: json['shipping_time'],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      cityId: (json['city_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CityAreaModelToJson(CityAreaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'has_area': instance.hasArea,
      'shipping_cost': instance.shippingCost,
      'shipping_time': instance.shippingTime,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'city_id': instance.cityId,
    };
