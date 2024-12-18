import 'package:beauty_queen/View/fav/favourtie_screen.dart';
import 'package:beauty_queen/View/user_profile/mydata_screen.dart';
import 'package:beauty_queen/View/user_profile/password_screen.dart';
import 'package:beauty_queen/const/app_images.dart';
import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/styles.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../const/app_colors.dart';
import '../../const/vars.dart';
import '../../controller/auth_controller/auth_controler.dart';
import '../../controller/wallet_controller/wallet_controller.dart';
import '../../widgets/based/error_pop_up.dart';
import '../../widgets/based/loading.dart';
import '../../widgets/dialog_widget.dart';
import '../../widgets/home/CustomNavBar2.dart';
import '../../widgets/user_profile/bottom_sheet_of_add_money.dart';
import '../about_me/about_app.dart';
import '../auth_view/login_page.dart';
import '../dialog_controller.dart';
import '../faq/faq_app.dart';
import '../notification/notification_screen.dart';
import 'mysticker_screen.dart';
import '../orders/orders_screen.dart';
import 'contact_us_screen.dart';

class NormalProfileScreen extends StatefulWidget {
  const NormalProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NormalProfileScreen();
  }
}

class _NormalProfileScreen extends State<NormalProfileScreen> {
  AuthController controller = Get.put(AuthController());
  WalletController controller2 = Get.put(WalletController());
  @override
  void initState() {
    super.initState();
    controller2.getAllWallet();
    showDialog();
  }

  final DialogController dialogController = Get.put(DialogController());
  showDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dialogController.addObjects(Get.find<AuthController>().popData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const ReusableBottomNavigationBar2(),
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
                        Text(
                            '${tr('hello')} ${controller.userData.value.name}❤️',
                            style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kPrimaryColor,
                              fontSize: 29.19.sp,
                              fontWeight: FontWeight.w600,
                            )),
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.kBlackColor,
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
                      Text(tr('accountType'),
                          style: TextStyle(
                            fontFamily: kTheArabicSansLight,
                            color: AppColors.kTextGrayColor,
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
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Text(tr('quna'),
                                    style: TextStyle(
                                      fontFamily: kTheArabicSansLight,
                                      color: AppColors.kWhiteColor,
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
                        Text(tr('normal'),
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
                    controller2.loadingWallet.value == true
                        ? const CupertinoActivityIndicator()
                        : Container(
                            height: 98.h,
                            width: 398.w,
                            decoration: BoxDecoration(
                              color: AppColors
                                  .kWhiteColor, // Set the fill color to white
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
                                            text: tr('wallet'),
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kTextGrayColor,
                                              fontSize: 16.58.sp,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        TextSpan(
                                            text:
                                                '${controller2.walletAmountState.value}  ',
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kPrimaryColor,
                                              fontSize: 28.45.sp,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        TextSpan(
                                            text: tr('Del'),
                                            style: TextStyle(
                                              fontFamily: kTheArabicSansLight,
                                              color: AppColors.kPrimaryColor,
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
                                    showModalSheet(context);
                                  },
                                  child: Container(
                                    height: 41.56.h,
                                    width: 107.w,
                                    decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(27.41.r)),
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.68.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30.h,
                                            width: 30.w,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.kWhiteColor,
                                            ),
                                            child: const Icon(
                                              Icons.add,
                                              color: AppColors.kPrimaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            tr('fill'),
                                            style: TextStyle(
                                                fontFamily: kTheArabicSansLight,
                                                color: AppColors.kWhiteColor,
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
                  SizedBox(
                    height: 115.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const OrdersScreen(),
                                  routeName: '/OrdersScreen');
                            },
                            child: Container(
                              height: 115.h,
                              width: 115.w,
                              decoration: BoxDecoration(
                                  color: AppColors.kWhiteColor,
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
                                  SvgPicture.asset(
                                    AppImages.myOrdersImage,
                                    // height: 66.11.h,
                                    // width: 54.w,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    tr('my_orders'),
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        15.pw,
                        ////////////second container//////////////
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(const FavScreen());
                            },
                            child: Container(
                              height: 115.h,
                              width: 115.w,
                              decoration: BoxDecoration(
                                  color: AppColors.kWhiteColor,
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
                                  SvgPicture.asset(
                                    AppImages.subFavImage,
                                    // height: 66.11.h,
                                    // width: 54.w,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    tr('fav'),
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (controller.userData.value.accountType ==
                            AccountTypes.queena) ...{
                          ////////////third container////////////////
                          15.pw,
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Get.to(const MyStickerScreen());
                            },
                            child: Container(
                              height: 115.h,
                              width: 115.w,
                              decoration: BoxDecoration(
                                  color: AppColors.kWhiteColor,
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
                                  SvgPicture.asset(
                                    AppImages.myStickerImage,
                                    // height: 66.11.h,
                                    // width: 54.w,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    tr('mines'),
                                    style: TextStyle(
                                        fontFamily: kTheArabicSansLight,
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          )),
                        }
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 46.h,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(const NotificationScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.notificationImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          tr('notification'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(const NotificationScreen());
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(const MyDataScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.profileImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          tr('ourData'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(const MyDataScreen());
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.to(const PasswordScreen());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.passwordImage),
                          SizedBox(
                            width: 25.w,
                          ),
                          Text(
                            tr('kPasswordHint'),
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kBlackColor,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.to(const PasswordScreen());
                              },
                              icon: const Icon(Icons.arrow_forward_ios))
                        ],
                      )),
                  const Divider(
                    color: AppColors.kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsScreen()));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.chatImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          tr('contact_us'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUsScreen()));
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(const FAQScreen());
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.infoCircleImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          tr('FAQ'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(const FAQScreen());
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.kDividerrColor,
                    thickness: 2,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutAppScreen()));
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.infoCircleImage),
                        SizedBox(
                          width: 25.w,
                        ),
                        Text(
                          tr('about_shop'),
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kBlackColor,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Get.to(const AboutAppScreen());
                            },
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                  ),
                  if (controller.userData.value.accountType !=
                      AccountTypes.queena) ...{
                    20.ph,
                    GestureDetector(
                      onTap: () async {
                        Get.to(const MyDataScreen(
                          openToEdit: true,
                          tryToUpgradeAccount: true,
                        ));
                      },
                      child: Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        width: 398.w,
                        decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(50.r)),
                        child: Text(
                          'الترقية الى حساب كوينا',
                          style: TextStyle(
                              fontFamily: kTheArabicSansLight,
                              color: AppColors.kWhiteColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  },
                  SizedBox(
                    height: 60.h,
                  ),
                  10.ph,
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
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout,
                            color: AppColors.kWhiteColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            tr('logout'),
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kWhiteColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.ph,
                  GestureDetector(
                    onTap: () async {
                      controller.deleteUserData();
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
                          color: AppColors.kPrimaryColor,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete,
                            color: AppColors.kWhiteColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'حذف الحساب',
                            style: TextStyle(
                                fontFamily: kTheArabicSansLight,
                                color: AppColors.kWhiteColor,
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
