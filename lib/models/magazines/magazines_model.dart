import 'package:json_annotation/json_annotation.dart';

import 'magazine_cover_model.dart';

part 'magazines_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MagazinesModel {
  int? id;
  String? title;
  String? isMagazinePurchasable;
  MagazineCoverModel? magazineCover;
  MagazineCoverModel? magazineFile;

  MagazinesModel(
      {this.id,
      this.title,
      this.isMagazinePurchasable,
      this.magazineCover,
      this.magazineFile});

  factory MagazinesModel.fromJson(Map<String, dynamic> json) {
    return _$MagazinesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MagazinesModelToJson(this);
}
