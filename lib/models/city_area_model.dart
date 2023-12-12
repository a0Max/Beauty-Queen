import 'package:json_annotation/json_annotation.dart';

part 'city_area_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CityAreaModel {
  int? id;
  String? name;
  String? hasArea;
  dynamic shippingCost;
  dynamic shippingTime;
  String? createdAt;
  String? updatedAt;
  int? cityId;

  CityAreaModel(
      {this.id,
        this.name,
        this.hasArea,
        this.shippingCost,
        this.shippingTime,
        this.createdAt,
        this.updatedAt,
        this.cityId});
  factory CityAreaModel.fromJson(Map<String, dynamic> json) {
    return _$CityAreaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityAreaModelToJson(this);
}