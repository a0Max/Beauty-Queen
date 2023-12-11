import 'offer_image_model.dart';

import 'package:json_annotation/json_annotation.dart';


part 'discover_brand.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DiscoverBrand {
  int? id;
  String? description;
  OfferImageModel? mobileImage;
  OfferImageModel? desktopImage;

  DiscoverBrand(
      {this.id, this.description, this.mobileImage, this.desktopImage});

  factory DiscoverBrand.fromJson(Map<String, dynamic> json) {
    return _$DiscoverBrandFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DiscoverBrandToJson(this);

}

