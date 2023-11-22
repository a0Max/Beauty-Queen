import 'dart:developer';
import 'package:beauty_queen/View/filterby_screen.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/images.dart';
import '../const/styles.dart';
import '../controller/FilterController.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomCardWidget.dart';
import '../widgets/custom_fliter_ container.dart';

class FliterScreen extends StatefulWidget {
  const FliterScreen({super.key});

  @override
  State<FliterScreen> createState() => _FliterScreenState();
}

class _FliterScreenState extends State<FliterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 0.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  double containerheight = 1.0;
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
    final PageController pageController = PageController();
    final FilterController filterController = Get.put(FilterController());
    int currentPage = 0;

    List<String> containerTexts = ["الوجه", "الحواجب", "العيون", "الشفاه"];
    // -1 means no selection

    return Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160.h),
          child: CustomAppBar(
            showFavIcon: false,
            showarrowIcon: true,
            showBagIcon2: true,

            onPressed: () {
              // Handle the button click here, e.g., open the end drawer.
              _scaffoldKey.currentState?.openEndDrawer();
            },
            isScrolled: _isScrolled,

            // Replace with your variable for scroll state
            searchBarWidth: searchBarWidth, // Replace with your desired width
            searchBarTranslationY: searchBarTranslationY,
            searchBarTranslationX: searchBarTranslationX,
          ),
        ),
        endDrawer: const MyEndDrawer(),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              height: 24.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 17.h),
                child: Obx(
                  () => Text.rich(TextSpan(
                      text: "الأقسام / ",
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kGrayColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: filterController.selectedLabel.value,
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kBlackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ])),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              height: 34.95.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4, // Change this to the number of containers you have
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 8.82.w),
                      child: Obx(
                        () => MyCustomContainer(
                          text: containerTexts[index],
                          isSelected:
                              filterController.selectedIndex.value == index,
                          onTap: () {
                            log("Tapped on container $index");
                            filterController.selectedIndex.value = index;
                            filterController.updateSubcategories(index);
                            log("Selected Index: ${filterController.selectedIndex}");
                            log("Subcategories: ${filterController.subcategories}");
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                height: filterController.subcategories.isNotEmpty ? 10.h : 0,
              ),
            ),
            // Display the list of subcategories
            Obx(
              () => SizedBox(
                height: filterController.subcategories.isNotEmpty ? 34.95.h : 0,
                child: ListView.builder(
                  key: ValueKey(filterController.subcategories.length),
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  itemCount: filterController.subcategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Container(
                        height: 34.95.h,
                        width: 92.12.w,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: kTextGrayColor, width: 1.w),
                            borderRadius: BorderRadius.circular(
                              9.43.r,
                            )),
                        child: Center(
                          child: Text(
                            filterController.subcategories[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: kTheArabicSansLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(
              height: 19.h,
            ),
//////////custom drop down////////////

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.transparent,
                            isDense: true,
                            isExpanded: true,

                            alignment: Alignment.center,
                            value: null, // Set the initial value to null
                            items: [
                              DropdownMenuItem<String>(
                                value: 'المضاف حديثاً',
                                child: Text('المضاف حديثاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'الأكثر مبيعاً',
                                child: Text('الأكثر مبيعاً',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من أقل الي الأعلي',
                                child: Text('السعر من أقل الي الأعلي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                              DropdownMenuItem<String>(
                                value: 'السعر من الأعلي أقل الي',
                                child: Text('السعر من الأعلي أقل الي',
                                    style: TextStyle(
                                      color: kBlackColor,
                                      fontSize: 14.sp,
                                      fontFamily: kTheArabicSansLight,
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    )),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              // Handle the selected option if needed
                            },
                            hint: Text('التصنيف حسب',
                                style: TextStyle(
                                  color: kBlackColor,
                                  fontSize: 18.sp,
                                  fontFamily: kTheArabicSansLight,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(ksortIconImage),
                        ),
                      ],
                    ),
                  ),
                  //////////////second///////////////
                  Container(
                    height: 39.76.h,
                    width: 180.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryColor, width: 1.5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(const FilterByContainer());
                          },
                          child: Text('فلترة النتائج',
                              style: TextStyle(
                                color: kBlackColor,
                                fontSize: 18.sp,
                                fontFamily: kTheArabicSansLight,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Image.asset(kfilterIconImage),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ////////////////////base///////////////
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 17.h),
                child: const Text("عدد المنتجات: 124",
                    style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: kGrayColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCardWidget(
                        imageUrl: kBaseImage,
                        imgtxt: 'Makeup Forever',
                        price: '150.00',
                        des: 'كريم اساس الترا اتش دي السائل من ميكب',
                        disprice: '190.00',
                        containertxt: 'تحديد الخيارات'),
                    CustomCardWidget(
                        imageUrl: kLispticImage,
                        imgtxt: 'Rare Beauty',
                        price: '94.00',
                        des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                        disprice: '94.00',
                        containertxt: 'إضافة إلي السلة'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCardWidget(
                        imageUrl: kBaseImage,
                        imgtxt: 'Makeup Forever',
                        price: '150.00',
                        des: 'كريم اساس الترا اتش دي السائل من ميكب',
                        disprice: '190.00',
                        containertxt: 'تحديد الخيارات'),
                    CustomCardWidget(
                        imageUrl: kLispticImage,
                        imgtxt: 'Rare Beauty',
                        price: '94.00',
                        des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                        disprice: '94.00',
                        containertxt: 'إضافة إلي السلة'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCardWidget(
                        imageUrl: kBaseImage,
                        imgtxt: 'Makeup Forever',
                        price: '150.00',
                        des: 'كريم اساس الترا اتش دي السائل من ميكب',
                        disprice: '190.00',
                        containertxt: 'تحديد الخيارات'),
                    CustomCardWidget(
                        imageUrl: kLispticImage,
                        imgtxt: 'Rare Beauty',
                        price: '94.00',
                        des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                        disprice: '94.00',
                        containertxt: 'إضافة إلي السلة'),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCardWidget(
                        imageUrl: kBaseImage,
                        imgtxt: 'Makeup Forever',
                        price: '150.00',
                        des: 'كريم اساس الترا اتش دي السائل من ميكب',
                        disprice: '190.00',
                        containertxt: 'تحديد الخيارات'),
                    CustomCardWidget(
                        imageUrl: kLispticImage,
                        imgtxt: 'Rare Beauty',
                        price: '94.00',
                        des: 'طقم فريش اند ديوي للشفاه والخدود من رير بيوتي',
                        disprice: '94.00',
                        containertxt: 'إضافة إلي السلة'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentPage > 0) {
                          currentPage--;
                          pageController.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                        " ${currentPage + 1}"), // Display the current page number
                    IconButton(
                      onPressed: () {
                        if (currentPage < 49) {
                          // Assuming you have a total of 50 pages
                          currentPage++;
                          pageController.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            )
          ]),
        ));
  }
}
