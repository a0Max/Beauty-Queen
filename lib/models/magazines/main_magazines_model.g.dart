// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_magazines_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainMagazinesModel _$MainMagazinesModelFromJson(Map<String, dynamic> json) =>
    MainMagazinesModel(
      magazines: (json['magazines'] as List<dynamic>?)
          ?.map((e) => MagazinesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] == null
          ? null
          : InfoModel.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MainMagazinesModelToJson(MainMagazinesModel instance) =>
    <String, dynamic>{
      'magazines': instance.magazines?.map((e) => e.toJson()).toList(),
      'info': instance.info?.toJson(),
    };
