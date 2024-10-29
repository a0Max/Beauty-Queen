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
      mobile: json['mobile'] == null
          ? null
          : OfferImageModel.fromJson(json['mobile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PopUpModelToJson(PopUpModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_link': instance.isLink,
      'desktop': instance.desktop?.toJson(),
      'mobile': instance.mobile?.toJson(),
    };
