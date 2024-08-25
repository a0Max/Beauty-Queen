import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../View/product_profile/products_screen.dart';
import '../View/welcome/welcome_screen.dart';
import '../controller/home_controller/home_controller.dart';
import '../controller/product_controller/product_profile_controller_provider.dart';
import 'vars.dart';

class UniLinkClient {
  static Future<bool?> launchAd(String link) async {
    BuildContext? context = Get.context;
    Uri uri = Uri.parse(link);

    if (uri.host != Connection.base) {
      try {
        await launchUrlString(link);
        return null;
      } catch (e, s) {
        print(e);
        print(s);
      }
    }
    print('uri:$uri');
    log('uri:$uri');
    log('pathSegments:${uri.pathSegments[0]}');
    log('uri:${uri.pathSegments[1]}');

    // if (uri.pathSegments.length < 2) return;
    // if (!UniVars.values
    //     .contains('${uri.pathSegments[0]}/${uri.pathSegments[1]}')) return;

    final id = int.tryParse(uri.pathSegments[1]);
    final HomeController _controllerHome = Get.put(HomeController());

    _controllerHome.getHomeDataController();
    try {
      switch (uri.pathSegments[0]) {
        case UniVars.product:
          if (id == null) return null;

          String? key = id.toString();
          Get.off(() => const WelcomeScreen());

          Get.to(() => ChangeNotifierProvider(
              create: (context) => ProductProfileControllerProvider(),
              child: ItemProfilePage(itemId: int.parse(key))));
          return true;
        default:
          return null;
      }
    } on DioError catch (e, s) {
      print(e);
      print(s);

      Navigator.of(context!).pop();
      return null;
    } catch (e, s) {
      print(e);
      print(s);
      Navigator.of(context!).pop();
      return null;
    }
  }
}
