import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'offer_image_model.dart';

part 'brand_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class BrandModel{
  int? id;
  String? title;
  String? titleAr;
  String? shortDescription;
  String? longDescription;
  String? isSpecial;
  String? isPublic;
  String? isHomepage;
  String? isDiscoverBrand;
  String? logo;
  String? logoBackground;
  String? sEODescription;
  String? keywords;
  String? createdAt;
  String? updatedAt;
  OfferImageModel? homepageBrandImage;
  List<OfferImageModel>? mobileSlides;

  BrandModel(
      {this.id,
        this.title,
        this.titleAr,
        this.shortDescription,
        this.longDescription,
        this.isSpecial,
        this.isPublic,
        this.isHomepage,
        this.isDiscoverBrand,
        this.logo,
        this.logoBackground,
        this.sEODescription,
        this.keywords,
        this.createdAt,
        this.mobileSlides,
        this.homepageBrandImage,
        this.updatedAt});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return _$BrandModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}