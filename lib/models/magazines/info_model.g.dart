// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) => InfoModel(
      description: json['description'] as String?,
      mobileBanner: json['mobile_banner'] == null
          ? null
          : MagazineCoverModel.fromJson(
              json['mobile_banner'] as Map<String, dynamic>),
      desktopBanner: json['desktop_banner'] == null
          ? null
          : MagazineCoverModel.fromJson(
              json['desktop_banner'] as Map<String, dynamic>),
      promoVideo: json['promo_video'] == null
          ? null
          : MagazineCoverModel.fromJson(
              json['promo_video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InfoModelToJson(InfoModel instance) => <String, dynamic>{
      'description': instance.description,
      'mobile_banner': instance.mobileBanner?.toJson(),
      'desktop_banner': instance.desktopBanner?.toJson(),
      'promo_video': instance.promoVideo?.toJson(),
    };
