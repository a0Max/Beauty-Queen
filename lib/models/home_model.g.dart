// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) => HomeModel(
      discover: json['discover'] == null
          ? null
          : DiscoverModel.fromJson(json['discover'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      organicItems: (json['organicItems'] as List<dynamic>?)
          ?.map((e) => SpecialsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => SlidesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newArrivals: (json['newArrivals'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      salesProducts: (json['salesProducts'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => SalesProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['brands'] as List<dynamic>?)
          ?.map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      slides: (json['slides'] as List<dynamic>?)
          ?.map((e) => SlidesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      specials: (json['specials'] as List<dynamic>?)
          ?.map((e) => SpecialsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      newItems: (json['newItems'] as List<dynamic>?)
          ?.map((e) => SpecialsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'salesProducts': instance.salesProducts?.map((e) => e.toJson()).toList(),
      'offers': instance.offers?.map((e) => e.toJson()).toList(),
      'brands': instance.brands?.map((e) => e.toJson()).toList(),
      'slides': instance.slides?.map((e) => e.toJson()).toList(),
      'specials': instance.specials?.map((e) => e.toJson()).toList(),
      'newItems': instance.newItems?.map((e) => e.toJson()).toList(),
      'organicItems': instance.organicItems?.map((e) => e.toJson()).toList(),
      'newArrivals': instance.newArrivals?.map((e) => e.toJson()).toList(),
      'banners': instance.banners?.map((e) => e.toJson()).toList(),
      'discover': instance.discover?.toJson(),
    };
