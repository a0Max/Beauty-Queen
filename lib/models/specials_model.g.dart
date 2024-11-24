// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialsModel _$SpecialsModelFromJson(Map<String, dynamic> json) =>
    SpecialsModel(
      id: (json['id'] as num?)?.toInt(),
      image: json['image'] as String?,
      description: json['description'] as String?,
      isLink: json['is_link'] as String?,
      linkType: json['link_type'] as String?,
      linkId: json['link_id'] as String?,
      urlLink: json['url_link'] as String?,
      itemType: json['item_type'] as String?,
      title: json['title'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$SpecialsModelToJson(SpecialsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
      'is_link': instance.isLink,
      'link_type': instance.linkType,
      'link_id': instance.linkId,
      'url_link': instance.urlLink,
      'item_type': instance.itemType,
      'title': instance.title,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
