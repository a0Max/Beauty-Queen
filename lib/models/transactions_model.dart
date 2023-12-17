import 'package:json_annotation/json_annotation.dart';

import 'offer_image_model.dart';

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