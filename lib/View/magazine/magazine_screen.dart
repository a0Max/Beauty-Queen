import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/styles.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/magazines_controller/magazines_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../models/magazines/magazines_model.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../cart/cart_screen.dart';
import 'widgets/item_of_magazine.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MagazineScreen();
  }
}

class _MagazineScreen extends State<MagazineScreen> {
  bool isLoading = false;
  final MagazinesController _controller = Get.put(MagazinesController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller.getMagazinesDataController();
  }

  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 10.0;
  void _scrollListener() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;

        searchBarWidth = 0.75;
        searchBarTranslationX = 50.0;
        searchBarTranslationY = -52.0;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
        searchBarWidth = 1.0;

        searchBarTranslationX = 0.0;
        searchBarTranslationY = 0.0;
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController userController = Get.put(AuthController());
  bool _isScrolled = false;
  final NavController _controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            userController.userData.value.accountType == AccountTypes.queena
                ? Size.fromHeight(80.h)
                : Size.fromHeight(100.h),
        child: Obx(() => CustomAppBar(
              showBagIcon: true,
              showFavIcon: true,
              showPersonIcon: true,
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              isScrolled: _isScrolled,
              countCart: _controllerNav.countCart.value,
              searchBarWidth: searchBarWidth, // Replace with your desired width
              searchBarTranslationY: searchBarTranslationY,
              searchBarTranslationX: searchBarTranslationX,
              // Replace with your desired translation value
            )),
      ),
      endDrawer: const MyEndDrawer(),
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Obx(() => _controller.isLoading.value == true
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl: Connection.magazineVideoUrl +
                              (_controller.magazinesData.value.info
                                      ?.mobileBanner?.file ??
                                  ''),
                          width: MediaQuery.of(context).size.width,
                          // height: 150,
                        ),
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width / 2,
                          // alignment: Alignment.center,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اكتشفي أحدث إصدارات مجلتنا الموسمية مع أهم اخبار عالم الجمال وصيحات الموسم',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    fontSize: 10,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              10.ph,
                              Text(
                                'تصفحي الآن',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                    decorationColor: Colors.white,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              15.ph
                            ],
                          ),
                        )
                      ],
                    ),
                    Center(
                      child: Text(
                        tr('inThisModel'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 21.sp,
                          fontFamily: kTheArabicSansBold,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    15.ph,
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: _controller.controller.value.aspectRatio,
                        child: VideoPlayer(_controller.controller),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Column(
                        children: [
                          15.ph,
                          Center(
                            child: Text(
                              tr('allModels'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 21.sp,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          10.ph,
                          Wrap(
                            runSpacing: 13,
                            spacing: 10,
                            children: List.generate(
                                _controller.magazinesData.value.magazines
                                        ?.length ??
                                    0,
                                (index) => ItemOfMagazine(
                                      data: _controller.magazinesData.value
                                              .magazines?[index] ??
                                          MagazinesModel(),
                                    )),
                          ),
                          20.ph,
                          Center(
                            child: Text(
                              tr('about_app'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 21.sp,
                                fontFamily: kTheArabicSansBold,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                          15.ph,
                          HtmlWidget(
                            _controller.magazinesData.value.info?.description ??
                                '',
                            textStyle: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ))),
    ));
  }
}
