import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'label_model.dart';
import 'pagination_model.dart';
import 'product_banner_model.dart';

part 'general_search_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GeneralSearchModel {
  PaginationModel? sales;
  PaginationModel? products;
  PaginationModel? offers;
  PaginationModel? gifts;
  int? salesCount;
  List<BrandModel>? brands;
  BrandModel? brand;
  List<String>? prices;
  List<LabelModel>? labels;
  ProductBanner? info;

  GeneralSearchModel(
      {this.sales,
        this.salesCount,
        this.offers,
        this.brands,
        this.gifts,
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