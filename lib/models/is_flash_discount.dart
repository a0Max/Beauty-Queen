import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'options_model.dart';

part 'is_flash_discount.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class IsFlashDiscount{
  bool? status;
  bool? endAt;

  IsFlashDiscount({this.status, this.endAt});


  factory IsFlashDiscount.fromJson(Map<String, dynamic> json) {
    return _$IsFlashDiscountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IsFlashDiscountToJson(this);
}