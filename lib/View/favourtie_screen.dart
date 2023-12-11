import 'package:beauty_queen/const/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/vars.dart';
import '../controller/home_controller/home_controller.dart';
import '../models/sales_products_model.dart';
import '../widgets/CustomCardWidget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FavScreen();
  }
}
class _FavScreen extends State<FavScreen>{
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
            "المفضلة",
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
        child: Obx(()=>Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 28.85.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 52.81.h,
                width: 133.36.w,
                decoration: BoxDecoration(
                    color: klPinkColor,
                    borderRadius: BorderRadius.circular(41.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: kPrimaryColor,
                          size: 30.r,
                        )),
                    Text(
                      "إزالــة",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.74.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 34.75.h,
            ),
            Wrap(
              runSpacing: 7,
              children: List.generate(
                  _controller.wishlistList.value.length,
                      (index) =>
                          CustomCardWidget(
                    imageUrl: Connection.urlOfProducts(
                        image: _controller
                            .wishlistList.value[index].product.mainImage ??
                            ''),
                    newArrival: _controller.wishlistList.value[index].product ??
                        SalesProductsModel(),
                  // )
              ),
            ),)
          ],
        )),
      ),
      // bottomNavigationBar: ReusableBottomNavigationBar(),
    );
  }
}
