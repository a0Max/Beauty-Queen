import 'package:beauty_queen/const/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

// import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../controller/product_controller/product_profile_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/CustomCardWidget.dart';

class TabScreenOne extends StatelessWidget {
  final ProductProfileController controller =
  Get.put(ProductProfileController());

   TabScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        HtmlWidget(controller.productData.value.product?.description??''),
        SizedBox(
          height: 17.h,
        ),
      ],
    );
  }
}
