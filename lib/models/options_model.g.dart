// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionsModel _$OptionsModelFromJson(Map<String, dynamic> json) => OptionsModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      code: json['code'] as String?,
      stock: json['stock'] as String?,
      price: json['price'] as String?,
      isSet: json['is_set'] as String?,
      isColor: json['is_color'] as String?,
      color: json['color'] as String?,
      specialKey: (json['special_key'] as num?)?.toInt(),
      isSize: json['is_size'] as String?,
      size: json['size'] as String?,
      isOffer: json['is_offer'] as String?,
      offerPrice: json['offer_price'] as String?,
      offerStartAt: json['offer_start_at'] as String?,
      offerEndAt: json['offer_end_at'] as String?,
      poID: (json['po_i_d'] as num?)?.toInt(),
      isFlashDiscount: json['is_flash_discount'] as String?,
      flashDiscountPrice: json['flash_discount_price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => OfferImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainImage: json['main_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['main_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OptionsModelToJson(OptionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'stock': instance.stock,
      'price': instance.price,
      'is_set': instance.isSet,
      'is_color': instance.isColor,
      'color': instance.color,
      'special_key': instance.specialKey,
      'is_size': instance.isSize,
      'size': instance.size,
      'is_offer': instance.isOffer,
      'offer_price': instance.offerPrice,
      'offer_start_at': instance.offerStartAt,
      'offer_end_at': instance.offerEndAt,
      'po_i_d': instance.poID,
      'is_flash_discount': instance.isFlashDiscount,
      'flash_discount_price': instance.flashDiscountPrice,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'main_image': instance.mainImage?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };
