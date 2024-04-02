// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazines_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazinesModel _$MagazinesModelFromJson(Map<String, dynamic> json) =>
    MagazinesModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      isMagazinePurchasable: json['is_magazine_purchasable'] as String?,
      magazineCover: json['magazine_cover'] == null
          ? null
          : MagazineCoverModel.fromJson(
              json['magazine_cover'] as Map<String, dynamic>),
      magazineFile: json['magazine_file'] == null
          ? null
          : MagazineCoverModel.fromJson(
              json['magazine_file'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MagazinesModelToJson(MagazinesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_magazine_purchasable': instance.isMagazinePurchasable,
      'magazine_cover': instance.magazineCover?.toJson(),
      'magazine_file': instance.magazineFile?.toJson(),
    };
