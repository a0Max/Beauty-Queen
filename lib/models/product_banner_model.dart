import 'package:json_annotation/json_annotation.dart';


part 'product_banner_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProductBanner {
  String? file;
  String? description;
  String? banner;
  String? bannerIsLink;
  String? bannerLinkType;
  String? bannerLinkId;
  String? bannerUrlLink;

  ProductBanner(
      {this.file,
        this.bannerIsLink,
        this.bannerLinkType,
        this.bannerLinkId,
        this.banner,
        this.description,
        this.bannerUrlLink});


  factory ProductBanner.fromJson(Map<String, dynamic> json) {
    return _$ProductBannerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductBannerToJson(this);
}