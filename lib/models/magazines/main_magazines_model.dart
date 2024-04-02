import 'package:json_annotation/json_annotation.dart';

import 'info_model.dart';
import 'magazines_model.dart';

part 'main_magazines_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MainMagazinesModel {
  List<MagazinesModel>? magazines;
  InfoModel? info;

  MainMagazinesModel({this.magazines, this.info});

  factory MainMagazinesModel.fromJson(Map<String, dynamic> json) {
    return _$MainMagazinesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainMagazinesModelToJson(this);
}
