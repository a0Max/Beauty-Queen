import 'package:json_annotation/json_annotation.dart';

import 'order_details_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrderModel {
  dynamic subtotal;
  dynamic discount;
  dynamic totalQty;
  dynamic shippingCost;
  dynamic totalPrice;
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
        discount: json['discount'],
        order: json['order'] == null
            ? null
            : OrderDetailsModel.fromJson(json['order'] as Map<String, dynamic>),
        subtotal: json['subtotal'],
        totalPrice: json['totalPrice'],
        totalQty: json['totalQty'],
        flashDiscountStatus: json['flashDiscountStatus'] as String?,
        flashDiscountEndAt: json['flashDiscountEndAt'] as String?);
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
