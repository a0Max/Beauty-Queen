// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      rowId: json['rowId'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      code: json['code'] as String?,
      brand_id: json['brand_id'] as int?,
      brand: json['brand'] as String?,
      main_image: json['main_image'] as String?,
      price: json['price'] as String?,
      is_offer: json['is_offer'] as String?,
      is_discount: json['is_discount'] as String?,
      offer_price: json['offer_price'] as String?,
      offer_start_at: json['offer_start_at'] as String?,
      offer_end_at: json['offer_end_at'] as String?,
      poID: json['poID'] as int?,
      poTitle: json['poTitle'] as String?,
      opTitle: json['opTitle'] as String?,
      opCode: json['opCode'] as String?,
      maximum_order_quantity: json['maximum_order_quantity'] as String?,
      stock: json['stock'] as String?,
      qty: json['qty'],
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'rowId': instance.rowId,
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'brand_id': instance.brand_id,
      'brand': instance.brand,
      'main_image': instance.main_image,
      'price': instance.price,
      'is_offer': instance.is_offer,
      'is_discount': instance.is_discount,
      'offer_price': instance.offer_price,
      'offer_start_at': instance.offer_start_at,
      'offer_end_at': instance.offer_end_at,
      'poID': instance.poID,
      'poTitle': instance.poTitle,
      'opTitle': instance.opTitle,
      'opCode': instance.opCode,
      'maximum_order_quantity': instance.maximum_order_quantity,
      'stock': instance.stock,
      'qty': instance.qty,
    };
