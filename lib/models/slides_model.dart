import 'package:json_annotation/json_annotation.dart';


part 'slides_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SlidesModel{
  int? id;
  String? desktop;
  String? banner;
  String? isPublic;
  String? mobile;
  String? isLink;
  String? linkType;
  String? linkId;
  String? urlLink;
  String? createdAt;
  String? updatedAt;

  SlidesModel(
      {this.id,
        this.desktop,
        this.isPublic,
        this.banner,
        this.mobile,
        this.isLink,
        this.linkType,
        this.linkId,
        this.urlLink,
        this.createdAt,
        this.updatedAt});

  factory SlidesModel.fromJson(Map<String, dynamic> json) {
    return _$SlidesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SlidesModelToJson(this);
}