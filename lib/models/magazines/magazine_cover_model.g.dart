// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_cover_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineCoverModel _$MagazineCoverModelFromJson(Map<String, dynamic> json) =>
    MagazineCoverModel(
      id: json['id'] as int?,
      size: json['size'] as String?,
      file: json['file'] as String?,
      path: json['path'] as String?,
      fullFile: json['full_file'] as String?,
      mimeType: json['mime_type'] as String?,
      fileType: json['file_type'] as String?,
      relationId: json['relation_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$MagazineCoverModelToJson(MagazineCoverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size': instance.size,
      'file': instance.file,
      'path': instance.path,
      'full_file': instance.fullFile,
      'mime_type': instance.mimeType,
      'file_type': instance.fileType,
      'relation_id': instance.relationId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
