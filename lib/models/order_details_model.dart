import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:json_annotation/json_annotation.dart';

import '../const/vars.dart';
import 'city_area_model.dart';
import 'transactions_model.dart';

part 'order_details_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrderDetailsModel {
  int? id;
  int? userId;
  String? address;
  String? email;
  String? phone;
  String? name;
  String? notes;
  int? cityId;
  int? areaId;
  String? isUsedPromoCode;
  dynamic promoCodeId;
  String? orderType;
  String? specialDiscount;
  String? status;
  String? cancelledBy;
  String? cancelReason;
  String? financialStatus;
  String? createdAt;
  String? updatedAt;
  String? paymentMethod;
  String? confirmedAt;
  dynamic queenaTypeOrder;
  List<TransactionsModel>? items;
  dynamic city;
  dynamic area;
  int? orderItems;
  double? price;

  OrderDetailsModel(
      {this.id,
      this.userId,
      this.address,
      this.email,
      this.phone,
      this.name,
      this.orderItems,
      this.price,
      this.notes,
      this.cityId,
      this.areaId,
      this.isUsedPromoCode,
      this.promoCodeId,
      this.orderType,
      this.specialDiscount,
      this.status,
      this.cancelledBy,
      this.cancelReason,
      this.financialStatus,
      this.createdAt,
      this.updatedAt,
      this.paymentMethod,
      this.confirmedAt,
      this.queenaTypeOrder,
      this.items,
      this.city,
      this.area});

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderDetailsModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        address: json['address'] as String?,
        orderItems: json['order_items'] as int?,
        price: (json['price'] as num?)?.toDouble(),
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        name: json['name'] as String?,
        notes: json['notes'] as String?,
        cityId: json['city_id'] as int?,
        areaId: json['area_id'] as int?,
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
        city: json['city'] == null
            ? null
            : CityAreaModel.fromJson(json['city'] as Map<String, dynamic>),
        area: json['area'] == null
            ? null
            : CityAreaModel.fromJson(json['area'] as Map<String, dynamic>),
      );
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError('Api Crash $e', s);
      return OrderDetailsModel(
          id: json['id'] as int?,
          userId: json['user_id'] as int?,
          address: json['address'] as String?,
          email: json['email'] as String?,
          phone: json['phone'] as String?,
          orderItems: json['order_items'] as int?,
          price: (json['price'] as num?)?.toDouble(),
          name: json['name'] as String?,
          notes: json['notes'] as String?,
          cityId: json['city_id'] as int?,
          areaId: json['area_id'] as int?,
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
              ?.map(
                  (e) => TransactionsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          city: json['city'] as String?,
          area: json['area'] as String?);
    }
  }

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);

  getTheTextOfFinalState() {
    if (status == OrderState.shipped) {
      return "تم التسليم";
    } else if (status == OrderState.cancelled) {
      return 'ألغيت';
    } else if (status == OrderState.pending) {
      return 'في انتظار التاكيد';
    } else if (status == OrderState.confirmed) {
      return 'تم تاكيد طلبك';
    } else if (status == OrderState.delayed) {
      return 'طلبك مؤجل';
    } else if (status == OrderState.readyToPickup) {
      return 'جاهز للاستلام';
    } else if (status == OrderState.atShippingAgent) {
      return 'طلبك لدي مندوب التوصيل';
    } else if (status == OrderState.inCart) {
      return 'في العربة';
    } else {
      return status;
    }
  }
}
