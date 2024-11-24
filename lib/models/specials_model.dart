import 'package:json_annotation/json_annotation.dart';


part 'specials_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SpecialsModel{
  int? id;
  String? image;
  String? description;
  String? isLink;
  String? linkType;
  String? linkId;
  String? urlLink;
  String? itemType;
  String? title;
  String? createdAt;
  String? updatedAt;

  SpecialsModel(
      {this.id,
        this.image,
        this.description,
        this.isLink,
        this.linkType,
        this.linkId,
        this.urlLink,
        this.itemType,
        this.title,
        this.createdAt,
        this.updatedAt});


  factory SpecialsModel.fromJson(Map<String, dynamic> json) {
    return _$SpecialsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SpecialsModelToJson(this);
}