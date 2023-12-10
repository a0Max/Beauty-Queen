// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesProductsModel _$SalesProductsModelFromJson(Map<String, dynamic> json) =>
    SalesProductsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      subTitle: json['sub_title'] as String?,
      note: json['note'] as String?,
      description: json['description'] as String?,
      code: json['code'] as String?,
      brandId: json['brand_id'] as int?,
      stock: json['stock'] as String?,
      price: json['price'] as String?,
      priceRangeFrom: json['price_range_from'] as String?,
      priceRangeTo: json['price_range_to'] as String?,
      maximumOrderQuantity: json['maximum_order_quantity'] as String?,
      isGift: json['is_gift'] as String?,
      isOffer: json['is_offer'] as String?,
      isDiscount: json['is_discount'] as String?,
      offerTitle: json['offer_title'] as String?,
      offerDescription: json['offer_description'] as String?,
      offerPrice: json['offer_price'] as String?,
      offerStartAt: json['offer_start_at'] as String?,
      offerEndAt: json['offer_end_at'] as String?,
      isFlashDiscount: json['is_flash_discount'] as String?,
      flashDiscountPrice: json['flash_discount_price'] as String?,
      mainImage: json['main_image'] as String?,
      isPublic: json['is_public'] as String?,
      isQueena: json['is_queena'] as String?,
      isOnlineOnly: json['is_online_only'] as String?,
      labeltag: json['labeltag'] as String?,
      offerImage: json['offer_image'] == null
          ? null
          : OfferImageModel.fromJson(
              json['offer_image'] as Map<String, dynamic>),
      labelColor: json['label_color'] as String?,
      labelId: json['label_id'] as num?,
      isOutOfStock: json['is_out_of_stock'] as String?,
      isCompleteYourOutfit: json['is_complete_your_outfit'] as String?,
      completeYourOutfitDescription:
          json['complete_your_outfit_description'] as String?,
      isBanner: json['is_banner'] as String?,
      bannerIsLink: json['banner_is_link'] as String?,
      bannerFile: json['banner_file'] as String?,
      bannerLinkType: json['banner_link_type'] as String?,
      bannerLinkId: json['banner_link_id'] as String?,
      isDiscoverBrand: json['is_discover_brand'] as String?,
      bannerUrlLink: json['banner_url_link'] as String?,
      sEOTitle: json['s_e_o_title'] as String?,
      sEODescription: json['s_e_o_description'] as String?,
      keywords: json['keywords'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      brand: json['brand'] == null
          ? null
          : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
      productOptions: (json['product_options'] as List<dynamic>?)
          ?.map((e) => ProductOptionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      label: json['label'] == null
          ? null
          : LabelModel.fromJson(json['label'] as Map<String, dynamic>),
      labels: (json['labels'] as List<dynamic>?)
          ?.map((e) => LabelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => OfferImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesProductsModelToJson(SalesProductsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'note': instance.note,
      'description': instance.description,
      'code': instance.code,
      'brand_id': instance.brandId,
      'stock': instance.stock,
      'price': instance.price,
      'price_range_from': instance.priceRangeFrom,
      'price_range_to': instance.priceRangeTo,
      'maximum_order_quantity': instance.maximumOrderQuantity,
      'is_gift': instance.isGift,
      'is_offer': instance.isOffer,
      'is_discount': instance.isDiscount,
      'offer_title': instance.offerTitle,
      'offer_description': instance.offerDescription,
      'offer_price': instance.offerPrice,
      'offer_start_at': instance.offerStartAt,
      'offer_end_at': instance.offerEndAt,
      'is_flash_discount': instance.isFlashDiscount,
      'flash_discount_price': instance.flashDiscountPrice,
      'main_image': instance.mainImage,
      'is_public': instance.isPublic,
      'is_queena': instance.isQueena,
      'is_online_only': instance.isOnlineOnly,
      'labeltag': instance.labeltag,
      'label_color': instance.labelColor,
      'label_id': instance.labelId,
      'is_out_of_stock': instance.isOutOfStock,
      'is_complete_your_outfit': instance.isCompleteYourOutfit,
      'complete_your_outfit_description':
          instance.completeYourOutfitDescription,
      'is_banner': instance.isBanner,
      'banner_is_link': instance.bannerIsLink,
      'banner_file': instance.bannerFile,
      'banner_link_type': instance.bannerLinkType,
      'banner_link_id': instance.bannerLinkId,
      'is_discover_brand': instance.isDiscoverBrand,
      'banner_url_link': instance.bannerUrlLink,
      's_e_o_title': instance.sEOTitle,
      's_e_o_description': instance.sEODescription,
      'keywords': instance.keywords,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'brand': instance.brand?.toJson(),
      'product_options':
          instance.productOptions?.map((e) => e.toJson()).toList(),
      'wishlist': instance.wishlist,
      'label': instance.label?.toJson(),
      'labels': instance.labels?.map((e) => e.toJson()).toList(),
      'offer_image': instance.offerImage?.toJson(),
      'category': instance.category?.map((e) => e.toJson()).toList(),
      'images': instance.images?.map((e) => e.toJson()).toList(),
    };
