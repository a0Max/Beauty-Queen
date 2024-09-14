// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalOfTransactionsModel _$TotalOfTransactionsModelFromJson(
        Map<String, dynamic> json) =>
    TotalOfTransactionsModel(
      queenaBalance: json['queena_balance'],
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TotalOfTransactionsModelToJson(
        TotalOfTransactionsModel instance) =>
    <String, dynamic>{
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
      'queena_balance': instance.queenaBalance,
    };

TransactionsModel _$TransactionsModelFromJson(Map<String, dynamic> json) =>
    TransactionsModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      orderId: (json['order_id'] as num?)?.toInt(),
      type: json['type'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      isQueena: json['is_queena'] as String?,
      queenaAmount: (json['queena_amount'] as num?)?.toInt(),
    )
      ..productId = (json['product_id'] as num?)?.toInt()
      ..poID = (json['po_i_d'] as num?)?.toInt()
      ..option = (json['option'] as num?)?.toInt()
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
