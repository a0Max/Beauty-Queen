import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'categories_model.dart';
import 'label_model.dart';
import 'pagination_model.dart';
import 'product_banner_model.dart';
import 'sub_categories_model.dart';

part 'general_search_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GeneralSearchModel {
  PaginationModel? sales;
  PaginationModel? products;
  PaginationModel? offers;
  PaginationModel? gifts;
  PaginationModel? newArrivals;
  int? salesCount;
  int? count;
  List<BrandModel>? brands;
  List<BrandModel>? brandsIds;
  BrandModel? brand;
  List<String>? prices;
  List<LabelModel>? labels;
  List<SubCategoryModel>? categories;
  ProductBanner? info;

  GeneralSearchModel(
      {this.sales,
      this.salesCount,
      this.newArrivals,
      this.offers,
      this.brandsIds,
      this.brands,
      this.count,
      this.gifts,
      this.categories,
      this.prices,
      this.brand,
      this.products,
      this.labels,
      this.info});

  factory GeneralSearchModel.fromJson(Map<String, dynamic> json) {
    return _$GeneralSearchModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GeneralSearchModelToJson(this);
}
