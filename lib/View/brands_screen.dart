// ignore_for_file: unnecessary_null_comparison

import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:beauty_queen/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../const/colors.dart';
import '../widgets/CustomEndDrawer.dart';
import '../widgets/custom_brands_logo_widget.dart';
import 'branddetail_screen.dart';

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

  List<Map<String, String>> brands = [
    {'name': '   اڤالون\nاورقانكس', 'alphabet': 'A', 'imagePath': kalbaImage},
    {'name': '   اڤالون\nاورقانكس', 'alphabet': 'A', 'imagePath': klambdaImage},
    {
      'name': '   اڤالون\nاورقانكس',
      'alphabet': 'B',
      'imagePath': kbinnaceImage
    },
    {'name': '   اڤالون\nاورقانكس', 'alphabet': 'B', 'imagePath': klBranuImage},
    // Add more brands with their respective alphabets and image paths
  ];
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: brands
                    .where((brand) =>
                        showAllBrands || brand['alphabet'] == selectedAlphabet)
                    .map((brand) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the BrandDetailScreen when the image is tapped.
                      Get.to(const BrandDetailScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Add some spacing between images
                      child: Column(children: [
                        Image.asset(
                          brand['imagePath']!,
                          height: 95.h,
                          width: 95.w,
                        ),
                        Text(brand['name']!,
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: kBlackColor,
                              fontSize: 12.64.sp,
                              fontWeight: FontWeight.w400,
                            )),
                      ]),
                    ),
                  );
                }).toList(),
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
                  'B',
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
                    color: kPrimaryColor, // Change the color of the line
                    thickness: 2.w, // Adjust the width of the line
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kalbaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kalbaImage,
                  productName: '   اڤالون\nاورقانكس',
                )
              ],
            ),

            //////////////second row////////////////
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kalbaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kalbaImage,
                  productName: '   اڤالون\nاورقانكس',
                )
              ],
            ),
            /////////////////row three///////////////////////////
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomProductWidget(
                  imagePath: kbinnaceImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klBranuImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kHammerImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                )
              ],
            ),
            /////////////////row four///////////////////////////
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomProductWidget(
                  imagePath: kbinnaceImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klBranuImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: kHammerImage,
                  productName: '   اڤالون\nاورقانكس',
                ),
                CustomProductWidget(
                  imagePath: klambdaImage,
                  productName: '   اڤالون\nاورقانكس',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
