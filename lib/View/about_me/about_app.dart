import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/colors.dart';
import '../../const/styles.dart';
import '../../controller/about_controller/about_app_controller.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../widgets/about_app/item_of_app.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AboutAppScreen();
  }
}
class _AboutAppScreen extends State<AboutAppScreen>{
  final AboutAppController _controller = Get.put(AboutAppController());

  @override
  void initState() {
    super.initState();
    _controller.geAbout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kWhiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: kWhiteColor,
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 30.r,
                color: kBlackColor,
              )),
        ],
        title: Text(
          tr('about_us'),
          style: TextStyle(
              fontFamily: kTheArabicSansLight,
              color: kBlackColor,
              fontSize: 27.sp,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Obx(()=>ListView(
        children: [
          20.ph,
          ...List.generate(_controller.aboutData.value.length??0, (index) => ItemOfApp(title: _controller.aboutData.value[index].title, description: _controller.aboutData.value[index].description,))
          // ItemOfApp(title: 'نبذه حول المتجر ',),
          // ItemOfApp(title: 'تاريخ المتجر',),
          // ItemOfApp(title: 'ادارة المتجر وفريق العمل',),
          // ItemOfApp(title: 'التجريب والعينات المجانية',),
          // ItemOfApp(title: 'خدمة التوصيل',),
          // ItemOfApp(title: 'الاستلام من المتجر',),
          // ItemOfApp(title: 'ترجيع منتج بعد الاستلام',),
          // ItemOfApp(title: 'سياسة الاستبدال',),
        ],
      )),
    );
  }
}
