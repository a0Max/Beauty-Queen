import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'options_model.dart';

part 'product_options_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductOptionsModel {
  int? id;
  String? title;
  int? productId;
  String? createdAt;
  String? updatedAt;
  List<OptionsModel>? options;

  ProductOptionsModel({this.id,
    this.title,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.options});

  factory ProductOptionsModel.fromJson(Map<String, dynamic> json) {
    return _$ProductOptionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductOptionsModelToJson(this);
}