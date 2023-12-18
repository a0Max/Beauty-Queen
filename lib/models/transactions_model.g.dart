// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsModel _$TransactionsModelFromJson(Map<String, dynamic> json) =>
    TransactionsModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      orderId: json['order_id'] as int?,
      type: json['type'] as String?,
      amount: json['amount'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isQueena: json['is_queena'] as String?,
      queenaAmount: json['queena_amount'] as int?,
    )
      ..productId = json['product_id'] as int?
      ..poID = json['po_i_d'] as int?
      ..option = json['option'] as int?
      ..price = json['price'] as String?
      ..quantity = json['quantity'] as String?
      ..status = json['status'] as String?
      ..products = (json['products'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..options = (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TransactionsModelToJson(TransactionsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'order_id': instance.orderId,
      'type': instance.type,
      'amount': instance.amount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_queena': instance.isQueena,
      'queena_amount': instance.queenaAmount,
      'product_id': instance.productId,
      'po_i_d': instance.poID,
      'option': instance.option,
      'price': instance.price,
      'quantity': instance.quantity,
      'status': instance.status,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };
