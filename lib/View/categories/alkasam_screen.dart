import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import '../../const/colors.dart';
import '../../const/app_colors.dart';
import '../../const/styles.dart';
import '../../controller/AlKasam_controller/alkasam_controller.dart';
import '../../controller/nav_bar_controller/NavBarController.dart';
import '../../widgets/CustomAppBar.dart';
import '../../widgets/CustomEndDrawer.dart';
import '../../widgets/categories/CustomGirdview.dart';

class AlKasamScreen extends StatefulWidget {
  final bool? showBack;
  const AlKasamScreen({super.key, this.showBack});

  @override
  State<AlKasamScreen> createState() => _AlKasamScreenState();
}

class _AlKasamScreenState extends State<AlKasamScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AlkasamController _controller = Get.put(AlkasamController());

  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double searchBarWidth = 1.0;
  double searchBarHeight = 1.0;
  double searchBarTranslationX = 0.0;
  double searchBarTranslationY = 0.0;
  final NavController _controllerNav = Get.put(NavController());

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _controller.getAlkasamDataController();

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
          preferredSize: Size.fromHeight(_isScrolled ? 100.h :160.h),
          child: CustomAppBar(
            showarrowIcon: widget.showBack==true?true:false,
            showBagIcon: widget.showBack==true?false:true,
            showFavIcon:  widget.showBack==true?false:true,
            showPersonIcon:  widget.showBack==true?false:true,

            countCart:_controllerNav.countCart.value,
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
                height: 0.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 17.w),
                  child: Text.rich(TextSpan(
                      text: " الرئيسية/ ",
                      style: TextStyle(
                        fontFamily: kTheArabicSansLight,
                        color: AppColors.kGrayColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: "الأقسام",
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: AppColors.kBlackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ])),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              const Directionality(
                  textDirection: TextDirection.ltr, child: CustomGridView()),
            ],
          ),
        ));
  }
}
