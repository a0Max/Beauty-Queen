import 'package:json_annotation/json_annotation.dart';

import 'products_model.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel {
  List<ProductsModel>? products;
  String? totalPrice;
  String? promoCode;
  int? totalQty;
  String? initialPrice;

  CartModel(
      {this.products,
      this.totalPrice,
      this.promoCode,
      this.totalQty,
      this.initialPrice});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
