import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'categories_model.dart';
import 'label_model.dart';
import 'options_model.dart';
import 'product_banner_model.dart';

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