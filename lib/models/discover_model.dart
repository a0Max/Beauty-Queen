import 'package:json_annotation/json_annotation.dart';

import 'sales_products_model.dart';
import 'slides_model.dart';

part 'discover_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DiscoverModel{
  SlidesModel? info;
  List<SalesProductsModel>? products;

  DiscoverModel({this.info, this.products});

  factory DiscoverModel.fromJson(Map<String, dynamic> json) {
    return _$DiscoverModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DiscoverModelToJson(this);
}