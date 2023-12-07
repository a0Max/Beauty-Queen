// ignore_for_file: unnecessary_null_comparison

import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../const/colors.dart';
import '../../const/vars.dart';
import '../../controller/brands_controller/brands_controller.dart';
import '../../widgets/CustomEndDrawer.dart';
import '../../widgets/custom_brands_logo_widget.dart';
import '../branddetail_screen.dart';
import 'package:quiver/strings.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<String> characters =
      List.generate(26, (index) => String.fromCharCode(65 + index));
  String? selectedAlphabet = '';
  bool showAllBrands = false;
  final BrandsController _controller = Get.put(BrandsController());

  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.h),
        child: CustomAppBar(
          showBagIcon2: true,
          showarrowIcon: true,
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
            Image.asset(kbannerImage),

            SizedBox(
              height: 30.h,
            ),
            // Alphabets, six per line
            for (int i = 0; i < characters.length; i += 6)
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int j = i; j < i + 6 && j < characters.length; j++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAlphabet = characters[j];
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          color: selectedAlphabet == characters[j] &&
                                  !showAllBrands
                              ? kPrimaryColor
                              : Colors.transparent,
                          child: Text(
                            characters[j],
                            style: TextStyle(
                                color: selectedAlphabet == characters[j] &&
                                        !showAllBrands
                                    ? Colors.white
                                    : kPrimaryColor,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    endIndent: 15.w,
                    indent: 15.w,
                    // Adjust the height of the horizontal line
                    color: kPrimaryColor, // Change the color of the line
                    thickness: 2.w, // Adjust the width of the line
                  ),
                ),
                Text(
                  selectedAlphabet != null ? ' $selectedAlphabet ' : 'Filter',
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      fontSize: 23.82.sp,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: Divider(
                    endIndent: 15.w,
                    indent: 15.w,
                    // Adjust the height of the horizontal line
                    color: kPrimaryColor, // Change the color of the line
                    thickness: 2.w, // Adjust the width of the line
                  ),
                ),
              ],
            ),
            isBlank(selectedAlphabet) == true
                ? Obx(() => Column(
                      children: List.generate(
                          _controller.brandsData.length,
                          (index) => Column(
                                children: [
                                  Text(selectedAlphabet.toString()),
                                  SizedBox(
                                    height: 30,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            endIndent: 15.w,
                                            indent: 15.w,
                                            // Adjust the height of the horizontal line
                                            color:
                                                kPrimaryColor, // Change the color of the line
                                            thickness: 2
                                                .w, // Adjust the width of the line
                                          ),
                                        ),
                                        Text(
                                          _controller.brandsData.keys
                                              .toList()[index],
                                          style: TextStyle(
                                              fontSize: 23.82.sp,
                                              fontFamily: kTheArabicSansLight,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            endIndent: 15.w,
                                            indent: 15.w,
                                            // Adjust the height of the horizontal line
                                            color:
                                                kPrimaryColor, // Change the color of the line
                                            thickness: 2
                                                .w, // Adjust the width of the line
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(_controller.brandsData[_controller.brandsData.keys.toList()[index]].length.toString())
                                  Wrap(
                                    spacing: 5,
                                    runSpacing: 10,
                                    children: List.generate(
                                      _controller
                                          .brandsData[_controller
                                              .brandsData.keys
                                              .toList()[index]]
                                          .length,
                                      (index2) => CustomProductWidget(
                                        imagePath: Connection.urlOfBrands(
                                            image: _controller
                                                    .brandsData[_controller
                                                            .brandsData.keys
                                                            .toList()[index]]
                                                        [index2]
                                                    .logo ??
                                                ''),
                                        productName: _controller
                                                .brandsData[_controller
                                                    .brandsData.keys
                                                    .toList()[index]][index2]
                                                .titleAr ??
                                            '',
                                      ),
                                    ),
                                  )
                                ],
                              )),
                    ))
                : SizedBox(),

            Obx(() => Column(
                  children: List.generate(
                      _controller.brandsData.length,
                      (index) => Column(
                            children: [
                              if (selectedAlphabet ==
                                  _controller.brandsData.keys
                                      .toList()[index]) ...{
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
                                          color:
                                              kPrimaryColor, // Change the color of the line
                                          thickness: 2
                                              .w, // Adjust the width of the line
                                        ),
                                      ),
                                      Text(
                                        selectedAlphabet.toString(),
                                        style: TextStyle(
                                            fontSize: 23.82.sp,
                                            fontFamily: kTheArabicSansLight,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          endIndent: 15.w,
                                          indent: 15.w,
                                          // Adjust the height of the horizontal line
                                          color:
                                              kPrimaryColor, // Change the color of the line
                                          thickness: 2
                                              .w, // Adjust the width of the line
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Text(_controller.brandsData[_controller.brandsData.keys.toList()[index]].length.toString())
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 10,
                                  children: List.generate(
                                    _controller
                                        .brandsData[_controller.brandsData.keys
                                            .toList()[index]]
                                        .length,
                                    (index2) {
                                      return CustomProductWidget(
                                        imagePath: Connection.urlOfBrands(
                                            image: _controller
                                                    .brandsData[_controller
                                                            .brandsData.keys
                                                            .toList()[index]]
                                                        [index2]
                                                    .logo ??
                                                ''),
                                        productName: _controller
                                                .brandsData[_controller
                                                    .brandsData.keys
                                                    .toList()[index]][index2]
                                                .titleAr ??
                                            '',
                                      );
                                    },
                                  ),
                                )
                              } else ...{
                                SizedBox()
                              }
                            ],
                          )),
                ))
          ],
        ),
      ),
    );
  }
}
