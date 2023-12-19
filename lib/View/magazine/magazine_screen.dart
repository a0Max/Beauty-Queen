import 'package:beauty_queen/const/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../const/app_colors.dart';
import '../../const/colors.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MagazineScreen();
  }
}

class _MagazineScreen extends State<MagazineScreen> {
  late final WebViewController _webViewController;
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 30.r,
                  color: AppColors.kBlackColor,
                )),
          ),
          Expanded(
            child: WebViewWidget(
              controller: _webViewController,
            ),
          )
        ],
      ),
    ));
  }
}
