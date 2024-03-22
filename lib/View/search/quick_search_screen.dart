import 'package:beauty_queen/const/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/search/search_controller.dart';
import '../../widgets/based/CustomAppBar.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../product_profile/products_screen.dart';

class QuickSearchScreen extends StatefulWidget {
  const QuickSearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuickSearchScreen();
  }
}

class _QuickSearchScreen extends State<QuickSearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController userController = Get.put(AuthController());
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 10.0;
  final ScrollController _scrollController = ScrollController();
  final NavController _controllerNav = Get.put(NavController());
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  final SearchController0 controller = Get.put(SearchController0());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize:
              userController.userData.value.accountType == AccountTypes.queena
                  ? Size.fromHeight(_isScrolled ? 80.h : 145.h)
                  : Size.fromHeight(_isScrolled ? 100.h : 160.h),
          child: CustomAppBar(
            makeSearchBarNotClickable: true,

            showFavIcon: false,
            showarrowIcon: true,
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },

            isScrolled: _isScrolled,
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
          ),
        ),
        endDrawer: const MyEndDrawer(),
        body: Obx(() => SingleChildScrollView(
            controller: _scrollController,
            child: controller.loadingQuickSearch.value == true
                ? const Center(child: CupertinoActivityIndicator())
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        controller.keyWord.value != ''
                            ? Row(
                                children: [
                                  Text(
                                    'عرض كل نتائج البحث عن ',
                                    style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      fontSize: 15.1.sp,
                                      fontWeight: FontWeight.w600,
                                      // color: AppColors.kPrimaryColor
                                    ),
                                  ),
                                  Text(
                                    controller.keyWord.value,
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        fontSize: 17.1.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.kPrimaryColor),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        20.ph,
                        Listener(
                            onPointerDown: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (conetxt, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ItemProfilePage(
                                                  itemId: controller
                                                          .generalQuickSearchData
                                                          .value
                                                          .products?[index]
                                                          .id ??
                                                      0)));
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: CachedNetworkImage(
                                              imageUrl: Connection.urlOfProducts(
                                                  image: controller
                                                          .generalQuickSearchData
                                                          .value
                                                          .products?[index]
                                                          .mainImage ??
                                                      '')),
                                        ),
                                        10.pw,
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              (10 + 70 + 40),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                        .generalQuickSearchData
                                                        .value
                                                        .products?[index]
                                                        .title ??
                                                    '',
                                                style: TextStyle(
                                                  fontFamily:
                                                      kTheArabicSansLight,
                                                  fontSize: 13.1.sp,
                                                  // fontWeight: FontWeight.w600,
                                                  // color: AppColors.kPrimaryColor
                                                ),
                                              ),
                                              const Text('...'),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (conetxt, index) {
                                  return 10.ph;
                                },
                                itemCount: controller.generalQuickSearchData
                                        .value.products?.length ??
                                    0)),
                      ],
                    ),
                  ))));
  }
}
