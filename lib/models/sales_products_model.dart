
import 'package:beauty_queen/models/brand_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'label_model.dart';
import 'offer_image_model.dart';
import 'product_options_model.dart';

part 'sales_products_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SalesProductsModel{
  int? id;
  String? title;
  String? subTitle;
  String? note;
  String? description;
  String? code;
  int? brandId;
  String? stock;
  String? price;
  String? priceRangeFrom;
  String? priceRangeTo;
  String? maximumOrderQuantity;
  String? isGift;
  String? isOffer;
  String? isDiscount;
  String? offerTitle;
  String? offerDescription;
  String? offerPrice;
  String? offerStartAt;
  String? offerEndAt;
  String? isFlashDiscount;
  String? flashDiscountPrice;
  String? mainImage;
  String? isPublic;
  String? isQueena;
  String? isOnlineOnly;
  String? labeltag;
  String? labelColor;
  num? labelId;
  String? isOutOfStock;
  String? isCompleteYourOutfit;
  String? completeYourOutfitDescription;
  String? isBanner;
  String? bannerIsLink;
  String? bannerFile;
  String? bannerLinkType;
  String? bannerLinkId;
  String? isDiscoverBrand;
  String? bannerUrlLink;
  String? sEOTitle;
  String? sEODescription;
  String? keywords;
  String? createdAt;
  String? updatedAt;
  BrandModel? brand;
  List<ProductOptionsModel>? productOptions;
  List<String>? wishlist;
  LabelModel? label;
  List<LabelModel>? labels;
  OfferImageModel? offerImage;

  SalesProductsModel(
      {this.id,
        this.title,
        this.subTitle,
        this.note,
        this.description,
        this.code,
        this.brandId,
        this.stock,
        this.price,
        this.priceRangeFrom,
        this.priceRangeTo,
        this.maximumOrderQuantity,
        this.isGift,
        this.isOffer,
        this.isDiscount,
        this.offerTitle,
        this.offerDescription,
        this.offerPrice,
        this.offerStartAt,
        this.offerEndAt,
        this.isFlashDiscount,
        this.flashDiscountPrice,
        this.mainImage,
        this.isPublic,
        this.isQueena,
        this.isOnlineOnly,
        this.labeltag,
        this.offerImage,
        this.labelColor,
        this.labelId,
        this.isOutOfStock,
        this.isCompleteYourOutfit,
        this.completeYourOutfitDescription,
        this.isBanner,
        this.bannerIsLink,
        this.bannerFile,
        this.bannerLinkType,
        this.bannerLinkId,
        this.isDiscoverBrand,
        this.bannerUrlLink,
        this.sEOTitle,
        this.sEODescription,
        this.keywords,
        this.createdAt,
        this.updatedAt,
        this.brand,
        this.productOptions,
        this.wishlist,
        this.label,
        this.labels});

  factory SalesProductsModel.fromJson(Map<String, dynamic> json) {
    return _$SalesProductsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SalesProductsModelToJson(this);
}