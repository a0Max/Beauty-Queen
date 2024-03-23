import 'package:beauty_queen/const/extensions.dart';
import 'package:beauty_queen/const/vars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../widgets/drawer/CustomEndDrawer.dart';
import '../cart/cart_screen.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MagazineScreen();
  }
}

class _MagazineScreen extends State<MagazineScreen> {
  late final WebViewController _webViewController;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              if (progress == 100) {
                isLoading = false;
              } else {
                isLoading = true;
              }
            });
          },
          onPageStarted: (url) async {
            print('url:$url');
            if (url.contains('magazine') == false) {
              Navigator.of(context).pop();
            }
          },
          onPageFinished: (url) async {
            if (url.contains('magazine') == false) {
              Navigator.of(context).pop();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(Connection.magazineUrl));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      endDrawer: const MyEndDrawer(),
      key: scaffoldKey,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  10.pw,
                  GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: SvgPicture.asset(
                      AppImages.imageMenu,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const CartScreen());
                    },
                    child: SvgPicture.asset(
                      AppImages.imageShop,
                      height: 30.h,
                      width: 30.w,
                    ),
                  ),
                  10.pw,
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kBlackColor,
                        size: 25,
                      )),
                  10.pw,
                ],
              ),
            ],
          ),
          Expanded(
            child: isLoading == true
                ? const CupertinoActivityIndicator()
                : WebViewWidget(
                    controller: _webViewController,
                  ),
          )
        ],
      ),
    ));
  }
}
