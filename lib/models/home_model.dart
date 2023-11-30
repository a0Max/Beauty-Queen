import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'categories_model.dart';
import 'discover_model.dart';
import 'sales_products_model.dart';
import 'slides_model.dart';
import 'specials_model.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel {
  List<CategoryModel>? categories;
  List<SalesProductsModel>? salesProducts;
  List<SalesProductsModel>? offers;
  List<BrandModel>? brands;
  List<SlidesModel>? slides;
  List<SpecialsModel>? specials;
  List<SpecialsModel>? newItems;
  List<SpecialsModel>? organicItems;
  List<SalesProductsModel>? newArrivals;
  List<SlidesModel>? banners;
  DiscoverModel? discover;

  HomeModel({this.discover, this.categories,this.organicItems,this.banners,this.newArrivals, this.salesProducts, this.offers, this.brands, this.slides, this.specials, this.newItems});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}