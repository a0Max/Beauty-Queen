import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offer_image_model.dart';
import 'options_model.dart';

part 'offer_image_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OfferImageModel{
  int? id;
  String? size;
  String? file;
  String? path;
  String? fullFile;
  String? mimeType;
  String? fileType;
  int? relationId;
  String? createdAt;
  String? updatedAt;

  OfferImageModel(
      {this.id,
        this.size,
        this.file,
        this.path,
        this.fullFile,
        this.mimeType,
        this.fileType,
        this.relationId,
        this.createdAt,
        this.updatedAt});

  factory OfferImageModel.fromJson(Map<String, dynamic> json) {
    return _$OfferImageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OfferImageModelToJson(this);
}