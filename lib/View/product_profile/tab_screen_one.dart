import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../const/styles.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../controller/product_controller/product_profile_controller_provider.dart';

class TabScreenOne extends StatelessWidget {
  // final ProductProfileController controller =
  //     Get.put(ProductProfileController());

  TabScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductProfileControllerProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        HtmlWidget(
          controller.productData.last.product?.description ?? '',
          textStyle: TextStyle(fontFamily: kTheArabicSansLight),
        ),
        SizedBox(
          height: 17.h,
        ),
      ],
    );
  }
}
