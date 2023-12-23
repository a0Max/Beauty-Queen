import 'package:json_annotation/json_annotation.dart';

import 'sales_products_model.dart';
import 'slides_model.dart';

part 'faq_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class FAQModel {
  int? id;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  String? image;

  FAQModel(
      {this.id,
      this.question,
      this.answer,
      this.createdAt,
      this.updatedAt,
      this.image});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return _$FAQModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FAQModelToJson(this);
}
