import 'package:json_annotation/json_annotation.dart';

import 'order_details_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrderModel {
  int? subtotal;
  int? discount;
  int? totalQty;
  dynamic shippingCost;
  int? totalPrice;
  OrderDetailsModel? order;
  String? flashDiscountStatus;
  String? flashDiscountEndAt;

  OrderModel(
      {this.shippingCost,
      this.discount,
      this.order,
      this.subtotal,
      this.flashDiscountStatus,
      this.flashDiscountEndAt,
      this.totalPrice,
      this.totalQty});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        shippingCost: json['shippingCost'],
        discount: json['discount'] as int?,
        order: json['order'] == null
            ? null
            : OrderDetailsModel.fromJson(json['order'] as Map<String, dynamic>),
        subtotal: json['subtotal'] as int?,
        totalPrice: json['totalPrice'] as int?,
        totalQty: json['totalQty'] as int?,
        flashDiscountStatus: json['flashDiscountStatus'] as String?,
        flashDiscountEndAt: json['flashDiscountEndAt'] as String?);
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
