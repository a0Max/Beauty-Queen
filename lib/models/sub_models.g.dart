// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubModels _$SubModelsFromJson(Map<String, dynamic> json) => SubModels(
      shippingCost: json['shippingCost'] as String?,
      shippingTime: json['shippingTime'] as String?,
      totalPrice: json['totalPrice'] as int?,
      orderID: json['orderID'] as int?,
      totalQty: json['totalQty'] as int?,
      areas: (json['areas'] as List<dynamic>?)
          ?.map((e) => CityAreaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubModelsToJson(SubModels instance) => <String, dynamic>{
      'totalPrice': instance.totalPrice,
      'totalQty': instance.totalQty,
      'orderID': instance.orderID,
      'areas': instance.areas?.map((e) => e.toJson()).toList(),
      'shippingCost': instance.shippingCost,
      'shippingTime': instance.shippingTime,
    };
