// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
    OrderDetailsModel(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      address: json['address'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      orderItems: (json['order_items'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      cityId: (json['city_id'] as num?)?.toInt(),
      areaId: (json['area_id'] as num?)?.toInt(),
      isUsedPromoCode: json['is_used_promo_code'] as String?,
      promoCodeId: json['promo_code_id'],
      orderType: json['order_type'] as String?,
      specialDiscount: json['special_discount'] as String?,
      status: json['status'] as String?,
      cancelledBy: json['cancelled_by'] as String?,
      cancelReason: json['cancel_reason'] as String?,
      financialStatus: json['financial_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      paymentMethod: json['payment_method'] as String?,
      confirmedAt: json['confirmed_at'] as String?,
      queenaTypeOrder: json['queena_type_order'],
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => TransactionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: json['city'],
      area: json['area'],
    );

Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'name': instance.name,
      'notes': instance.notes,
      'city_id': instance.cityId,
      'area_id': instance.areaId,
      'is_used_promo_code': instance.isUsedPromoCode,
      'promo_code_id': instance.promoCodeId,
      'order_type': instance.orderType,
      'special_discount': instance.specialDiscount,
      'status': instance.status,
      'cancelled_by': instance.cancelledBy,
      'cancel_reason': instance.cancelReason,
      'financial_status': instance.financialStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'payment_method': instance.paymentMethod,
      'confirmed_at': instance.confirmedAt,
      'queena_type_order': instance.queenaTypeOrder,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'city': instance.city,
      'area': instance.area,
      'order_items': instance.orderItems,
      'price': instance.price,
    };
