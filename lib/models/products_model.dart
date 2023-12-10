
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsModel{
  String? rowId;
  int? id;
  String? title;
  String? code;
  int? brand_id;
  String? brand;
  String? main_image;
  String? price;
  String? is_offer;
  String? is_discount;
  String? offer_price;
  String? offer_start_at;
  String? offer_end_at;
  int? poID;
  String? poTitle;
  String? opTitle;
  String? opCode;
  String? maximum_order_quantity;
  String? stock;
  var qty;

  ProductsModel(
      {this.rowId,
        this.id,
        this.title,
        this.code,
        this.brand_id,
        this.brand,
        this.main_image,
        this.price,
        this.is_offer,
        this.is_discount,
        this.offer_price,
        this.offer_start_at,
        this.offer_end_at,
        this.poID,
        this.poTitle,
        this.opTitle,
        this.opCode,
        this.maximum_order_quantity,
        this.stock,
        this.qty});


  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return _$ProductsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}