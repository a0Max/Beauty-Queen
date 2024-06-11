import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'categories_model.dart';
import 'discover_model.dart';
import 'magazines/info_model.dart';
import 'sales_products_model.dart';
import 'slides_model.dart';
import 'specials_model.dart';

part 'home_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomeModel {
  List<CategoryModel>? categories;
  List<SalesProductsModel>? salesProducts;
  List<SalesProductsModel>? offers;
  List<SalesProductsModel>? flash_discount_products;
  List<BrandModel>? brands;
  List<SlidesModel>? slides;
  List<SpecialsModel>? specials;
  List<SpecialsModel>? newItems;
  List<SpecialsModel>? organicItems;
  List<SalesProductsModel>? newArrivals;
  List<SlidesModel>? banners;
  DiscoverModel? discover;
  String? flash_discount_title;
  String? flash_discount_desktop_image;
  String? flash_discount_mobile_image;
  String? flash_discount_end_at;
  String? flash_discount_status;
  InfoModel? magazine;

  HomeModel(
      {this.discover,
      this.flash_discount_title,
      this.flash_discount_desktop_image,
      this.flash_discount_products,
      this.flash_discount_status,
      this.flash_discount_mobile_image,
      this.flash_discount_end_at,
      this.categories,
      this.organicItems,
      this.banners,
      this.newArrivals,
      this.salesProducts,
      this.magazine,
      this.offers,
      this.brands,
      this.slides,
      this.specials,
      this.newItems});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    log('flash_discount_status:${json['flash_discount_status']}');
    return _$HomeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
