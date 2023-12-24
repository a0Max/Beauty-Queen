import 'package:json_annotation/json_annotation.dart';

import 'options_model.dart';
import 'sales_products_model.dart';

part 'transactions_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TransactionsModel{
  int? id;
  int? userId;
  int? orderId;
  String? type;
  int? amount;
  String? createdAt;
  String? updatedAt;
  String? isQueena;
  int? queenaAmount;
  int? productId;
  int? poID;
  int? option;
  String? price;
  String? quantity;
  String? status;
  List<SalesProductsModel>? products;
  List<OptionsModel>? options;
  TransactionsModel(
      {this.id,
        this.userId,
        this.orderId,
        this.type,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.isQueena,
        this.queenaAmount});

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return _$TransactionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransactionsModelToJson(this);
}