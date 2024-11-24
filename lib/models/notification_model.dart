import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class NotificationModel {
  String? id;
  int? userId;
  String? isAdmin;
  String? text;
  String? specialLine;
  String? isSentByAdmin;
  String? isLink;
  String? linkType;
  String? linkId;
  String? urlLink;
  String? isRead;
  String? mobileTitle;
  String? mobileBody;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
      this.userId,
      this.isAdmin,
      this.text,
      this.specialLine,
      this.mobileTitle,
      this.mobileBody,
      this.isSentByAdmin,
      this.isLink,
      this.linkType,
      this.linkId,
      this.urlLink,
      this.isRead,
      this.createdAt,
      this.updatedAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return _$NotificationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
