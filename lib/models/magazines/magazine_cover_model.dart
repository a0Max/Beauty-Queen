import 'package:json_annotation/json_annotation.dart';

part 'magazine_cover_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MagazineCoverModel {
  int? id;
  String? size;
  String? file;
  String? path;
  String? fullFile;
  String? mimeType;
  String? fileType;
  int? relationId;
  String? createdAt;
  String? updatedAt;

  MagazineCoverModel(
      {this.id,
      this.size,
      this.file,
      this.path,
      this.fullFile,
      this.mimeType,
      this.fileType,
      this.relationId,
      this.createdAt,
      this.updatedAt});

  factory MagazineCoverModel.fromJson(Map<String, dynamic> json) {
    return _$MagazineCoverModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MagazineCoverModelToJson(this);
}
