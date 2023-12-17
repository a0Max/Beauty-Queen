// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentsModel _$DepartmentsModelFromJson(Map<String, dynamic> json) =>
    DepartmentsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      coverImage: json['cover_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['cover_image'] as Map<String, dynamic>),
      mainImage: json['main_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['main_image'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => OfferImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$DepartmentsModelToJson(DepartmentsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'cover_image': instance.coverImage?.toJson(),
      'main_image': instance.mainImage?.toJson(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };
