import 'package:json_annotation/json_annotation.dart';

part 'departments_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DepartmentsModel {
  int? id;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? image;


  DepartmentsModel(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.createdAt,
        this.updatedAt});
  factory DepartmentsModel.fromJson(Map<String, dynamic> json) {
    return _$DepartmentsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentsModelToJson(this);
}