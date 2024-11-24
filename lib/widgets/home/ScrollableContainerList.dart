// ignore_for_file: file_names

import 'package:beauty_queen/models/brand_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../View/brands/branddetail_screen.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../models/user_model.dart';

class ScrollableContainerList extends StatelessWidget {
  List<BrandModel> listOfBrands;
  ScrollableContainerList({super.key, required this.listOfBrands});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265.11.h,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 255.11.h,
          viewportFraction: 0.7,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          scrollDirection: Axis.horizontal,
          scrollPhysics: BouncingScrollPhysics(),
        ),
        items: List.generate(
            listOfBrands.length,
            (index) => GestureDetector(
                  onTap: () {
                    final AuthController _controllerLogin =
                        Get.put(AuthController());
                    UserModel user = _controllerLogin.userData.value;
                    print('%%%%%%%%%:${user.id}');
                    if (user.id == null) {
                      _controllerLogin.alertOfLogin();
                      return;
                    }
                    Get.to(BrandDetailScreen(
                      brandId: listOfBrands[index].id ?? 0,
                    ));
                  },
                  child: Container(
                    width: 265.11.w,
                    height: 265.11.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(Connection.urlOfBrands(
                            image:
                                listOfBrands[index].homepageBrandImage?.file ??
                                    '')),
                        fit: BoxFit.cover,
                      ),
                    ),
                    margin: EdgeInsets.all(10.r),
                  ),
                )),
        //   ;
        // },
        // ),
      ),
    );
  }
}
