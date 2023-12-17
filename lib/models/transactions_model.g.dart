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
    );

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
    };
