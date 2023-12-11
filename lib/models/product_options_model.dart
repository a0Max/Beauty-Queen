import 'package:json_annotation/json_annotation.dart';

import 'categories_model.dart';
import 'options_model.dart';
import 'sales_products_model.dart';

part 'product_options_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductOptionsModel {
  int? id;
  String? title;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<OptionsModel>? options;
  SalesProductsModel? product;
  List<CategoryModel>? category;
  CategoryModel? category2;

  ProductOptionsModel(
      {this.id,
      this.title,
      this.productId,
        this.product,
        this.userId,
      this.createdAt,
      this.updatedAt,
      this.options,
      this.category2,
      this.category});

  factory ProductOptionsModel.fromJson(Map<String, dynamic> json) {
    // return _$ProductOptionsModelFromJson(json);

    try {
      return ProductOptionsModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        productId: json['product_id'] as int?,
        userId: json['user_id'] as int?,
        createdAt: json['created_at'] as String?,
        product: json['product'] == null
            ? null
            : SalesProductsModel.fromJson(json['product'] as Map<String, dynamic>),
        updatedAt: json['updated_at'] as String?,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        category: (json['category'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return ProductOptionsModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        productId: json['product_id'] as int?,
        createdAt: json['created_at'] as String?,
        product: json['product'] == null
            ? null
            : SalesProductsModel.fromJson(json['product'] as Map<String, dynamic>),
        userId: json['user_id'] as int?,
        updatedAt: json['updated_at'] as String?,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        category2: json['category'] == null
            ? null
            : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      );
    }
  }

  Map<String, dynamic> toJson() => _$ProductOptionsModelToJson(this);
}
