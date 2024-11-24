// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverBrand _$DiscoverBrandFromJson(Map<String, dynamic> json) =>
    DiscoverBrand(
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      mobileImage: json['mobile_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['mobile_image'] as Map<String, dynamic>),
      desktopImage: json['desktop_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['desktop_image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscoverBrandToJson(DiscoverBrand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'mobile_image': instance.mobileImage?.toJson(),
      'desktop_image': instance.desktopImage?.toJson(),
    };
