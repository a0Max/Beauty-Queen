import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'options_model.dart';

part 'options_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OptionsModel {
  int? id;
  String? title;
  String? code;
  String? stock;
  String? price;
  String? isSet;
  String? isColor;
  String? color;
  int? specialKey;
  String? isSize;
  String? size;
  String? isOffer;
  String? offerPrice;
  String? offerStartAt;
  String? offerEndAt;
  int? poID;
  String? isFlashDiscount;
  String? flashDiscountPrice;
  String? createdAt;
  String? updatedAt;

  OptionsModel({this.id,
    this.title,
    this.code,
    this.stock,
    this.price,
    this.isSet,
    this.isColor,
    this.color,
    this.specialKey,
    this.isSize,
    this.size,
    this.isOffer,
    this.offerPrice,
    this.offerStartAt,
    this.offerEndAt,
    this.poID,
    this.isFlashDiscount,
    this.flashDiscountPrice,
    this.createdAt,
    this.updatedAt});


  factory OptionsModel.fromJson(Map<String, dynamic> json) {
    return _$OptionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionsModelToJson(this);
}