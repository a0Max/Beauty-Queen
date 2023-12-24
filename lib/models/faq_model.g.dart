// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQModel _$FAQModelFromJson(Map<String, dynamic> json) => FAQModel(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$FAQModelToJson(FAQModel instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
    };
