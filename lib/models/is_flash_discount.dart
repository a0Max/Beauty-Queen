import 'package:json_annotation/json_annotation.dart';

part 'is_flash_discount.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class IsFlashDiscount {
  dynamic status;
  dynamic endAt;

  IsFlashDiscount({this.status, this.endAt});

  factory IsFlashDiscount.fromJson(Map<String, dynamic> json) {
    return _$IsFlashDiscountFromJson(json);
  }

  Map<String, dynamic> toJson() => _$IsFlashDiscountToJson(this);
}
