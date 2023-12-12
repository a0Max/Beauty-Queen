import 'package:beauty_queen/View/favourtie_screen.dart';
import 'package:beauty_queen/View/user_profile/mydata_screen.dart';
import 'package:beauty_queen/View/user_profile/password_screen.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:beauty_queen/const/images.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../about_app.dart';
import '../auth_view/login_page.dart';
import '../mysticker_screen.dart';
import '../orders_screen.dart';
import '../profile_screen.dart';

class NormalProfileScreen extends StatelessWidget {
  const NormalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('مرحبا ${controller.userData.value.name}❤️',
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: kPrimaryColor,
                              fontSize: 29.19.sp,
                              fontWeight: FontWeight.w600,
                            )),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: kBlackColor,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Row(
                    children: [
                      Text('نوع الحساب',
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kTextGrayColor,
                            fontSize: 18.19.sp,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      if (controller.userData.value.accountType ==
                          AccountTypes.queena) ...{
                        Container(
                          height: 30.57.h,
                          width: 81.19.w,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text('كوينا',
                                    style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      color: kWhiteColor,
                                      fontSize: 18.19.sp,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset(
                                      AppImages.accountStarsImage)),
                            ],
                          ),
                        ),
                      } else ...{
                        Text('عادي',
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.mainColor,
                              fontSize: 18.19.sp,
                              fontWeight: FontWeight.w500,
                            ))
                      }
                    ],
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  if (controller.userData.value.accountType ==
                      AccountTypes.queena) ...{
                    Container(
                      height: 98.h,
                      width: 398.w,
                      decoration: BoxDecoration(
                        color: kWhiteColor, // Set the fill color to white
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(32, 0, 0, 0),
                            blurRadius: 28.r,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 24.w),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'محفظتي\n',
                                      style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: kTextGrayColor,
                                        fontSize: 16.58.sp,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  TextSpan(
                                      text: '100.00  ',
                                      style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: kPrimaryColor,
                                        fontSize: 28.45.sp,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  TextSpan(
                                      text: 'دل',
                                      style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: kPrimaryColor,
                                        fontSize: 24.45.sp,
                                        fontWeight: FontWeight.w600,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _showModalSheet(context);
                            },
                            child: Container(
                              height: 41.56.h,
                              width: 107.w,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(27.41.r)),
                              child: Padding(
                                padding: EdgeInsets.only(right: 5.68.w),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30.h,
                                      width: 30.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kWhiteColor,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'تعبئة',
                                      style: TextStyle(
                                          fontFamily: kTheArabicSansLight,
                                          color: kWhiteColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 19.w,
                          ),
                        ],
                      ),
                    ),
                  },
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const OrdersScreen());
                        },
                        child: Container(
                          height: 115.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(32, 0, 0, 0),
                                  blurRadius: 28.r,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kgiftImage,
                                height: 66.11.h,
                                width: 54.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'طلباتي',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: kPrimaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      ////////////second container//////////////
                      GestureDetector(
                        onTap: () {
                          Get.to(const FavScreen());
                        },
                        child: Container(
                          height: 115.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(32, 0, 0, 0),
                                  blurRadius: 28.r,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kfavImage,
                                height: 66.11.h,
                                width: 54.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'المفضلة',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: kPrimaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      ////////////third container////////////////
                      GestureDetector(
                        onTap: () {
                          Get.to(const MyStickerScreen());
                        },
                        child: Container(
                          height: 115.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(32, 0, 0, 0),
                                  blurRadius: 28.r,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kqueenImage,
                                height: 66.11.h,
                                width: 54.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'ملصقاتي',
                                style: TextStyle(
                                    fontFamily: kTheArabicSansLight,
                                    color: kPrimaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(MyDataScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.profileImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          'بياناتي',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(MyDataScreen());
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  const Divider(
                    color: kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.to( PasswordScreen());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.passwordImage),
                          SizedBox(
                            width: 25.w,
                          ),
                          Text(
                            'كلمة المرور',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: kBlackColor,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.to( PasswordScreen());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      )),
                  const Divider(
                    color: kDividerrColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Image.asset(kchatIconImage),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'تواصل معنا',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kBlackColor,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()));
                          },
                          icon: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                  const Divider(
                    color: kDividerrColor,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Image.asset(kiconCircleImage),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'حـول المتجر',
                        style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kBlackColor,
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AboutAppScreen()));
                          },
                          icon: const Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      //
                      controller.logoutUserData();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      height: 60.h,
                      width: 398.w,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: kWhiteColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: kWhiteColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

void _showModalSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: kWhiteColor,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  size: 30.r,
                  color: kPrimaryColor,
                )),
          ],
          title: Text(
            "المحفظة",
            style: TextStyle(
                fontFamily: kTheArabicSansLight,
                color: kBlackColor,
                fontSize: 23.74.sp,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "تعبئة رصيد المحفظة ",
                  style: TextStyle(
                      fontFamily: kTheArabicSansLight,
                      color: kPrimaryColor,
                      fontSize: 23.74.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 68.29.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      border: Border.all(width: 1, color: kPrimaryColor)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        fillColor: klPinkColor,
                        prefixIcon: Image.asset(ksubtractImage),
                        hintText: 'أدخل رقم البطاقة',
                        hintStyle: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: kPrimaryColor,
                            fontSize: 21.1.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Container(
                  height: 68.h,
                  width: 398.w,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(47.r)),
                  child: Center(
                    child: Text(
                      "تعبئة الرصيد ",
                      style: TextStyle(
                          fontFamily: kTheArabicSansLight,
                          color: kWhiteColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
