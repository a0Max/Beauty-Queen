import 'package:json_annotation/json_annotation.dart';

import 'offer_image_model.dart';

part 'sub_categories_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SubCategoryModel {
  int? id;
  String? title;
  OfferImageModel? image;
  SubCategoryModel({this.id, this.title, this.image});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return _$SubCategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}
