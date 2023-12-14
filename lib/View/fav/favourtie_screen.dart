import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../const/vars.dart';
import '../../controller/home_controller/home_controller.dart';
import '../../models/sales_products_model.dart';
import '../../widgets/product_profile/CustomCardWidget.dart';
import '../../widgets/shimmer/shimmer_item.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavScreen();
  }
}

class _FavScreen extends State<FavScreen> {
  final HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _controller.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: kWhiteColor,
          title: Text(
            tr('fav'),
            style: TextStyle(
                color: kBlackColor,
                fontSize: 27.74.sp,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: kBlackColor,
                  size: 30,
                )),
          ]),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 28.85.h,
                ),
                _controller.isLoadingWishlist.value == true
                    ?
                Wrap(
                  runSpacing: 7,
                  children:
                  List.generate(2, (index) => const ShimmerItem(isDelete:true)),
                )
                    :Wrap(
                  runSpacing: 7,
                  children: List.generate(
                    _controller.wishlistList.value.length,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.removeWishlist(
                                postId:
                                    _controller.wishlistList.value[index].id ??
                                        0);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              10.pw,
                              SvgPicture.asset(AppImages.imageDelete2),
                              5.pw,
                              Text(
                                tr('del_item'),
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 18.74.sp,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        10.ph,
                        CustomCardWidget(
                          imageUrl: Connection.urlOfProducts(
                              image: _controller.wishlistList.value[index]
                                      .product.mainImage ??
                                  ''),
                          newArrival:
                              _controller.wishlistList.value[index].product ??
                                  SalesProductsModel(),
                          // )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
      // bottomNavigationBar: ReusableBottomNavigationBar(),
    );
  }
}
