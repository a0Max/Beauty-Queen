// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => BrandModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      titleAr: json['title_ar'] as String?,
      shortDescription: json['short_description'] as String?,
      longDescription: json['long_description'] as String?,
      isSpecial: json['is_special'] as String?,
      isPublic: json['is_public'] as String?,
      isHomepage: json['is_homepage'] as String?,
      isDiscoverBrand: json['is_discover_brand'] as String?,
      logo: json['logo'] as String?,
      logoBackground: json['logo_background'] as String?,
      sEODescription: json['s_e_o_description'] as String?,
      keywords: json['keywords'] as String?,
      createdAt: json['created_at'] as String?,
      mobileSlides: (json['mobile_slides'] as List<dynamic>?)
          ?.map((e) => OfferImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepageBrandImage: json['homepage_brand_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['homepage_brand_image'] as Map<String, dynamic>),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'short_description': instance.shortDescription,
      'long_description': instance.longDescription,
      'is_special': instance.isSpecial,
      'is_public': instance.isPublic,
      'is_homepage': instance.isHomepage,
      'is_discover_brand': instance.isDiscoverBrand,
      'logo': instance.logo,
      'logo_background': instance.logoBackground,
      's_e_o_description': instance.sEODescription,
      'keywords': instance.keywords,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'homepage_brand_image': instance.homepageBrandImage?.toJson(),
      'mobile_slides': instance.mobileSlides?.map((e) => e.toJson()).toList(),
    };
