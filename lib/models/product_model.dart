import 'package:json_annotation/json_annotation.dart';

import 'discover_brand.dart';
import 'is_flash_discount.dart';
import 'product_banner_model.dart';
import 'product_options_model.dart';
import 'sales_products_model.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  SalesProductsModel? product;
  List<ProductOptionsModel>? productCategories;
  List<ProductOptionsModel>? productOptions;
  List<SalesProductsModel>? sameBrandProducts;
  List<SalesProductsModel>? p;
  IsFlashDiscount? is_flash_discount;
  ProductBanner? product_banner;
  DiscoverBrand? discover_brand;

  ProductModel(
      {this.product,
      this.productCategories,
      this.productOptions,
      this.sameBrandProducts,
      this.p,
      this.is_flash_discount,
      this.product_banner,
      this.discover_brand});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<SalesProductsModel> testP = [];
    if (json['p'] != null) {
      List<dynamic> listOfLists = json['p'];
      for (List<dynamic> innerList in listOfLists) {
        for (dynamic innerMap in innerList) {
          testP.add(SalesProductsModel.fromJson(innerMap));
        }
      }
    }
    return ProductModel(
      p: testP,
      product: json['product'] == null
          ? null
          : SalesProductsModel.fromJson(
              json['product'] as Map<String, dynamic>),
      productCategories: (json['productCategories'] as List<dynamic>?)
          ?.map((e) => ProductOptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productOptions: (json['productOptions'] as List<dynamic>?)
          ?.map((e) => ProductOptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sameBrandProducts: (json['sameBrandProducts'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_flash_discount: json['is_flash_discount'] == null
          ? null
          : IsFlashDiscount.fromJson(
              json['is_flash_discount'] as Map<String, dynamic>),
      product_banner: json['product_banner'] == null
          ? null
          : ProductBanner.fromJson(
              json['product_banner'] as Map<String, dynamic>),
      discover_brand: json['discover_brand'] == null
          ? null
          : DiscoverBrand.fromJson(
              json['discover_brand'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  List<String> getMinMax() {
    List<String> finalPrices = ['', ''];
    if (productOptions?.isEmpty??true){
      finalPrices[1] = (product?.price ?? '');

      return finalPrices;
    }
    String? min = productOptions?.first.options?.map((obj) => obj.price).reduce(
        (min, price) =>
            double.parse(price ?? '') < double.parse(min ?? '') ? price : min);
    String? max = productOptions?.first.options?.map((obj) => obj.price).reduce(
        (max, price) =>
            double.parse(price ?? '') > double.parse(min ?? '') ? price : max);
    finalPrices[0] = (min ?? '');
    finalPrices[1] = (max ?? '');
    print(finalPrices);
    return finalPrices;
  }
}
