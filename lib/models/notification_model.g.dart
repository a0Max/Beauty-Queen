// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      isAdmin: json['is_admin'] as String?,
      text: json['text'] as String?,
      specialLine: json['special_line'] as String?,
      mobileTitle: json['mobile_title'] as String?,
      mobileBody: json['mobile_body'] as String?,
      isSentByAdmin: json['is_sent_by_admin'] as String?,
      isLink: json['is_link'] as String?,
      linkType: json['link_type'] as String?,
      linkId: json['link_id'] as String?,
      urlLink: json['url_link'] as String?,
      isRead: json['is_read'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'is_admin': instance.isAdmin,
      'text': instance.text,
      'special_line': instance.specialLine,
      'is_sent_by_admin': instance.isSentByAdmin,
      'is_link': instance.isLink,
      'link_type': instance.linkType,
      'link_id': instance.linkId,
      'url_link': instance.urlLink,
      'is_read': instance.isRead,
      'mobile_title': instance.mobileTitle,
      'mobile_body': instance.mobileBody,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
