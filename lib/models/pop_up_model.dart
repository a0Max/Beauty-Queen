import 'package:json_annotation/json_annotation.dart';

import 'links_model.dart';
import 'offer_image_model.dart';
import 'sales_products_model.dart';

part 'pop_up_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PopUpModel {
  int? id;
  String? isLink;
  String? linkType;
  String? urlLink;
  String? linkId;
  OfferImageModel? desktop;
  OfferImageModel? mobile;

  PopUpModel(
      {this.id,
      this.isLink,
      this.desktop,
      this.urlLink,
      this.mobile,
      this.linkId,
      this.linkType});

  factory PopUpModel.fromJson(Map<String, dynamic> json) {
    return _$PopUpModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PopUpModelToJson(this);
}
