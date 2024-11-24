import 'package:json_annotation/json_annotation.dart';


part 'links_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LinksModel{
  String? url;
  String? label;
  bool? active;

  LinksModel({this.url, this.label, this.active});

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return _$LinksModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LinksModelToJson(this);
}