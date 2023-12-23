import 'package:beauty_queen/const/app_colors.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../controller/about_controller/about_app_controller.dart';

class ItemOfApp extends StatelessWidget {
  final String title;
  final String description;
  final AboutAppController controller = AboutAppController();

  ItemOfApp({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => GestureDetector(
              onTap: () {
                print(controller.stateOfMenu.value);
                controller.changeStateOfMenu();
                print(controller.stateOfMenu.value);
              },
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SizedBox(
                  // height: 100,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontSize: 18, color: AppColors.mainColor),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                      ),
                      const Divider(),
                      if (controller.stateOfMenu.value == true) ...{
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: HtmlWidget(description),
                        ),
                      }
                    ],
                  ),
                ),
              ),
            )),
        // 10.ph
      ],
    );
  }
}
