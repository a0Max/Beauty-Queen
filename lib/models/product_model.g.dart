// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      product: json['product'] == null
          ? null
          : SalesProductsModel.fromJson(
              json['product'] as Map<String, dynamic>),
      productCategories: (json['productCategories'] as List<dynamic>?)
          ?.map((e) => ProductOptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productOptions: (json['productOptions'] as List<dynamic>?)
          ?.map((e) => ProductOptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sameBrandProducts: (json['sameBrandProducts'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      p: (json['p'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      completeYourOutfit: (json['completeYourOutfit'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_flash_discount: json['is_flash_discount'] == null
          ? null
          : IsFlashDiscount.fromJson(
              json['is_flash_discount'] as Map<String, dynamic>),
      product_banner: json['product_banner'] == null
          ? null
          : ProductBanner.fromJson(
              json['product_banner'] as Map<String, dynamic>),
      discover_brand: json['discover_brand'] == null
          ? null
          : DiscoverBrand.fromJson(
              json['discover_brand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product': instance.product?.toJson(),
      'productCategories':
          instance.productCategories?.map((e) => e.toJson()).toList(),
      'productOptions':
          instance.productOptions?.map((e) => e.toJson()).toList(),
      'sameBrandProducts':
          instance.sameBrandProducts?.map((e) => e.toJson()).toList(),
      'completeYourOutfit':
          instance.completeYourOutfit?.map((e) => e.toJson()).toList(),
      'p': instance.p?.map((e) => e.toJson()).toList(),
      'reviews': instance.reviews?.map((e) => e.toJson()).toList(),
      'offers': instance.offers?.map((e) => e.toJson()).toList(),
      'is_flash_discount': instance.is_flash_discount?.toJson(),
      'product_banner': instance.product_banner?.toJson(),
      'discover_brand': instance.discover_brand?.toJson(),
    };
