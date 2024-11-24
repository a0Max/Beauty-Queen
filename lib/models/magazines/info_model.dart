import 'magazine_cover_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class InfoModel {
  String? description;
  MagazineCoverModel? mobileBanner;
  MagazineCoverModel? banner;
  MagazineCoverModel? desktopBanner;
  MagazineCoverModel? promoVideo;

  InfoModel(
      {this.description,
      this.mobileBanner,
      this.banner,
      this.desktopBanner,
      this.promoVideo});

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return _$InfoModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}
