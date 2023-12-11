import 'package:json_annotation/json_annotation.dart';


part 'label_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LabelModel{
  int? id;
  String? text;
  String? textColor;
  String? backgroundColor;
  String? createdAt;
  String? updatedAt;

  LabelModel(
      {this.id,
        this.text,
        this.textColor,
        this.backgroundColor,
        this.createdAt,
        this.updatedAt});


  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return _$LabelModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LabelModelToJson(this);
}