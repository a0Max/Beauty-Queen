import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'categories_model.dart';
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
  List<CategoryModel>? category;
  CategoryModel? category2;

  ProductOptionsModel(
      {this.id,
      this.title,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.options,
      this.category2,
      this.category});

  factory ProductOptionsModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductOptionsModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        productId: json['product_id'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        category: (json['category'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return ProductOptionsModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        productId: json['product_id'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        category2: json['category'] == null
            ? null
            : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      );
    }
  }

  Map<String, dynamic> toJson() => _$ProductOptionsModelToJson(this);
}
