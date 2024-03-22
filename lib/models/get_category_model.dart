import 'package:json_annotation/json_annotation.dart';

import 'categories_model.dart';

part 'get_category_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetCategoryModel {
  CategoryModel? category;
  List<CategoryModel>? parents;
  GetCategoryModel({this.category, this.parents});

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$GetCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetCategoryModelToJson(this);
}
