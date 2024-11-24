// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pop_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopUpModel _$PopUpModelFromJson(Map<String, dynamic> json) => PopUpModel(
      id: (json['id'] as num?)?.toInt(),
      isLink: json['is_link'] as String?,
      desktop: json['desktop'] == null
          ? null
          : OfferImageModel.fromJson(json['desktop'] as Map<String, dynamic>),
      urlLink: json['url_link'] as String?,
      mobile: json['mobile'] == null
          ? null
          : OfferImageModel.fromJson(json['mobile'] as Map<String, dynamic>),
      linkId: json['link_id'] as String?,
      linkType: json['link_type'] as String?,
    );

Map<String, dynamic> _$PopUpModelToJson(PopUpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_link': instance.isLink,
      'link_type': instance.linkType,
      'url_link': instance.urlLink,
      'link_id': instance.linkId,
      'desktop': instance.desktop?.toJson(),
      'mobile': instance.mobile?.toJson(),
    };
