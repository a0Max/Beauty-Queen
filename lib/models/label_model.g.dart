// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelModel _$LabelModelFromJson(Map<String, dynamic> json) => LabelModel(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      textColor: json['text_color'] as String?,
      backgroundColor: json['background_color'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$LabelModelToJson(LabelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'text_color': instance.textColor,
      'background_color': instance.backgroundColor,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
