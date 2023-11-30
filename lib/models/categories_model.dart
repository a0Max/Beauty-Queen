import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CategoryModel {
  int? id;
  String? title;
  String? description;
  String? parentId;
  String? sEOTitle;
  String? sEODescription;
  String? keywords;
  String? image;
  String? isSpecial;
  String? isPublic;
  String? bannerIsLink;
  String? bannerLinkType;
  String? bannerLinkId;
  String? bannerUrlLink;
  String? createdAt;
  String? updatedAt;

  CategoryModel(
      {this.id,
      this.title,
      this.description,
      this.parentId,
      this.sEOTitle,
      this.sEODescription,
      this.keywords,
      this.image,
      this.isSpecial,
      this.isPublic,
      this.bannerIsLink,
      this.bannerLinkType,
      this.bannerLinkId,
      this.bannerUrlLink,
      this.createdAt,
      this.updatedAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
