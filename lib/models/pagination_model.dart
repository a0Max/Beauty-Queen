import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'categories_model.dart';
import 'label_model.dart';
import 'links_model.dart';
import 'options_model.dart';
import 'product_banner_model.dart';
import 'sales_products_model.dart';

part 'pagination_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PaginationModel{
  int? currentPage;
  List<SalesProductsModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<LinksModel>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginationModel(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return _$PaginationModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}