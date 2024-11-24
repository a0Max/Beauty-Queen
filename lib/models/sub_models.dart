import 'package:json_annotation/json_annotation.dart';

import 'city_area_model.dart';

part 'sub_models.g.dart';

@JsonSerializable(explicitToJson: true)
class SubModels {
  int? totalPrice = 0;
  int? totalQty = 0;
  int? orderID = 0;
  List<CityAreaModel>? areas = [];
  String? shippingCost = '0';
  String? shippingTime = '';

  SubModels(
      {this.shippingCost,
      this.shippingTime,
      this.totalPrice,
      this.orderID,
      this.totalQty,
      this.areas});

  factory SubModels.fromJson(Map<String, dynamic> json) {
    return _$SubModelsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SubModelsToJson(this);
}
