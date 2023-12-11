// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      parentId: json['parent_id'] as num?,
      sEOTitle: json['s_e_o_title'] as String?,
      sEODescription: json['s_e_o_description'] as String?,
      keywords: json['keywords'] as String?,
      image: json['image'] as String?,
      isSpecial: json['is_special'] as String?,
      isPublic: json['is_public'] as String?,
      bannerIsLink: json['banner_is_link'] as String?,
      bannerLinkType: json['banner_link_type'] as String?,
      bannerLinkId: json['banner_link_id'] as String?,
      bannerUrlLink: json['banner_url_link'] as String?,
      createdAt: json['created_at'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'parent_id': instance.parentId,
      's_e_o_title': instance.sEOTitle,
      's_e_o_description': instance.sEODescription,
      'keywords': instance.keywords,
      'image': instance.image,
      'is_special': instance.isSpecial,
      'is_public': instance.isPublic,
      'banner_is_link': instance.bannerIsLink,
      'banner_link_type': instance.bannerLinkType,
      'banner_link_id': instance.bannerLinkId,
      'banner_url_link': instance.bannerUrlLink,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'children': instance.children?.map((e) => e.toJson()).toList(),
    };
