// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBanner _$ProductBannerFromJson(Map<String, dynamic> json) =>
    ProductBanner(
      file: json['file'] as String?,
      bannerIsLink: json['banner_is_link'] as String?,
      bannerLinkType: json['banner_link_type'] as String?,
      bannerLinkId: json['banner_link_id'] as String?,
      banner: json['banner'] as String?,
      description: json['description'] as String?,
      bannerUrlLink: json['banner_url_link'] as String?,
    );

Map<String, dynamic> _$ProductBannerToJson(ProductBanner instance) =>
    <String, dynamic>{
      'file': instance.file,
      'description': instance.description,
      'banner': instance.banner,
      'banner_is_link': instance.bannerIsLink,
      'banner_link_type': instance.bannerLinkType,
      'banner_link_id': instance.bannerLinkId,
      'banner_url_link': instance.bannerUrlLink,
    };
