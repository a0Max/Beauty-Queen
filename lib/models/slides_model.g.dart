// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slides_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlidesModel _$SlidesModelFromJson(Map<String, dynamic> json) => SlidesModel(
      id: (json['id'] as num?)?.toInt(),
      desktop: json['desktop'] as String?,
      isPublic: json['is_public'] as String?,
      banner: json['banner'] as String?,
      mobile: json['mobile'] as String?,
      isLink: json['is_link'] as String?,
      linkType: json['link_type'] as String?,
      linkId: json['link_id'] as String?,
      urlLink: json['url_link'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SlidesModelToJson(SlidesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'desktop': instance.desktop,
      'banner': instance.banner,
      'is_public': instance.isPublic,
      'mobile': instance.mobile,
      'is_link': instance.isLink,
      'link_type': instance.linkType,
      'link_id': instance.linkId,
      'url_link': instance.urlLink,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
