import 'package:json_annotation/json_annotation.dart';

import 'brand_model.dart';
import 'label_model.dart';
import 'pagination_model.dart';
import 'product_banner_model.dart';

class GeneralQuickSearchModel {
  List<GeneralQuickSearchModel0>? products;

  GeneralQuickSearchModel({this.products});

  GeneralQuickSearchModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <GeneralQuickSearchModel0>[];
      json['products'].forEach((v) {
        products!.add(new GeneralQuickSearchModel0.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralQuickSearchModel0 {
  int? id;
  String? title;
  String? mainImage;

  GeneralQuickSearchModel0({this.id, this.title, this.mainImage});

  GeneralQuickSearchModel0.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    mainImage = json['main_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['main_image'] = mainImage;
    return data;
  }
}
