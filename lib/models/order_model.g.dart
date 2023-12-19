// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      shippingCost: json['shipping_cost'] as String?,
      discount: json['discount'] as int?,
      order: json['order'] == null
          ? null
          : OrderDetailsModel.fromJson(json['order'] as Map<String, dynamic>),
      subtotal: json['subtotal'] as int?,
      totalPrice: json['total_price'] as int?,
      totalQty: json['total_qty'] as int?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'discount': instance.discount,
      'total_qty': instance.totalQty,
      'shipping_cost': instance.shippingCost,
      'total_price': instance.totalPrice,
      'order': instance.order?.toJson(),
    };