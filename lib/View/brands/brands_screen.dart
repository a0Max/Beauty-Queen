import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/based/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../controller/brands_controller/brands_controller.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../../widgets/brands/custom_brands_logo_widget.dart';
import '../../widgets/home/CustomNavBar2.dart';

class BrandScreen extends StatefulWidget {
  final bool? showBack;

  const BrandScreen({super.key, this.showBack});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  // String? selectedAlphabet = '';
  bool showAllBrands = false;
  final BrandsController _controller = Get.put(BrandsController());

  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;

  final ScrollController _scrollController = ScrollController();
  // final GlobalKey<_ListItemState> _targetKey = GlobalKey<_ListItemState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final NavController _controllerNav = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller.getBrandsDataController();
  }

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
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToColumn(String columnKey) {
    final index = columnKey.codeUnitAt(0) - 'A'.codeUnitAt(0);
    if (index >= 0 && index < _columnKeys.length) {
      final RenderBox renderBox =
          _columnKeys[index].currentContext?.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      _scrollController.animateTo(
        position.dy,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (columnKey == '0-9' && _controller.nonEnglishKeysMap.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  final List<GlobalKey> _columnKeys = List.generate(
    0,
    (index) => GlobalKey(),
  );
  final AuthController userController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar:
          widget.showBack == true ? const ReusableBottomNavigationBar2() : null,
      appBar: PreferredSize(
        preferredSize:
            userController.userData.value.accountType == AccountTypes.queena
                ? Size.fromHeight(80.h)
                : Size.fromHeight(100.h),
        child: CustomAppBar(
          showarrowIcon: widget.showBack == true ? true : false,
          showBagIcon: true,
          showFavIcon: widget.showBack == true ? false : true,
          showPersonIcon: widget.showBack == true ? false : true,

          countCart: _controllerNav.countCart.value,
          onPressed: () {
            // Handle the button click here, e.g., open the end drawer.
            _scaffoldKey.currentState?.openEndDrawer();
          },
          isScrolled: _isScrolled,
          // Replace with your variable for scroll state
          searchBarWidth: searchBarWidth, // Replace with your desired width
          searchBarTranslationY: searchBarTranslationY,
          searchBarTranslationX: searchBarTranslationX,
          // Replace with your desired translation value
        ),
      ),
      endDrawer: const MyEndDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Image.asset(AppImages.kbannerImage),
            SizedBox(
              height: 30.h,
            ),
            for (int i = 0; i < _controller.characters.length; i += 6)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int j = i;
                        j < i + 6 && j < _controller.characters.length;
                        j++)
                      // if (_controller.characters[j] != '') ...{
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (_controller.characters[j] != '') {
                              _scrollToColumn(_controller.characters[j]);
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(
                              _controller.characters[j],
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 16 +
                                      (0.6 *
                                          MediaQuery.of(context).size.width /
                                          100),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    // }
                    // Expanded(child: SizedBox()),
                    // Expanded(child: SizedBox())
                  ],
                ),
              ),
            Obx(() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    _columnKeys.add(GlobalKey());
                    return Column(
                      key: _columnKeys[index],
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  endIndent: 15.w,
                                  indent: 15.w,
                                  // Adjust the height of the horizontal line
                                  color: AppColors
                                      .kPrimaryColor, // Change the color of the line
                                  thickness:
                                      2.w, // Adjust the width of the line
                                ),
                              ),
                              Text(
                                _controller.brandsData.keys.toList()[index],
                                style: TextStyle(
                                    fontSize: 23.82.sp,
                                    fontFamily: kTheArabicSansLight,
                                    color: AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              Expanded(
                                child: Divider(
                                  endIndent: 15.w,
                                  indent: 15.w,
                                  // Adjust the height of the horizontal line
                                  color: AppColors
                                      .kPrimaryColor, // Change the color of the line
                                  thickness:
                                      2.w, // Adjust the width of the line
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.ph,
                        Wrap(
                          spacing: 10,
                          runSpacing: 30,
                          alignment: WrapAlignment.center,
                          children: List.generate(
                            _controller
                                .brandsData[
                                    _controller.brandsData.keys.toList()[index]]
                                .length,
                            (index2) => CustomProductWidget(
                              imagePath: Connection.urlOfBrands(
                                  image: _controller
                                          .brandsData[_controller
                                              .brandsData.keys
                                              .toList()[index]][index2]
                                          .logo ??
                                      ''),
                              productName: _controller
                                      .brandsData[_controller.brandsData.keys
                                          .toList()[index]][index2]
                                      .titleAr ??
                                  '',
                              brandId: _controller
                                  .brandsData[_controller.brandsData.keys
                                      .toList()[index]][index2]
                                  .id
                                  .toString(),
                            ),
                          ),
                        ),
                        23.ph,
                      ],
                    );
                  },
                  itemCount: _controller.brandsData.length,
                ))
          ],
        ),
      ),
    );
  }
}
