import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/colors.dart';
import '../const/styles.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/CustomEndDrawer.dart';
import '../widgets/CustomGirdview.dart';

class AlKasamScreen extends StatefulWidget {
  const AlKasamScreen({super.key});

  @override
  State<AlKasamScreen> createState() => _AlKasamScreenState();
}

class _AlKasamScreenState extends State<AlKasamScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;

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
            showarrowIcon: true,
            // showarrowIcon2: true,
            // showBagIcon: true,
            // showFavIcon: true,
            // showPersonIcon: true,
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
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 17.w),
                  child: Text.rich(TextSpan(
                      text: " الرئيسية/ ",
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: kGrayColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "الأقسام",
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
              SizedBox(
                height: 27.h,
              ),
              Directionality(
                  textDirection: TextDirection.ltr, child: CustomGridView()),
            ],
          ),
        ));
  }
}
