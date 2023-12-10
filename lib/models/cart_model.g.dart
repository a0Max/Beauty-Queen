// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as String?,
      promoCode: json['promoCode'] as String?,
      totalQty: json['totalQty'] as int?,
      initialPrice: json['initialPrice'] as String?,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'totalPrice': instance.totalPrice,
      'promoCode': instance.promoCode,
      'totalQty': instance.totalQty,
      'initialPrice': instance.initialPrice,
    };
