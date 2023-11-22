import 'package:beauty_queen/View/splash_screen.dart';
import 'package:beauty_queen/const/colors.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: kWhiteColor,
              useMaterial3: true,
            ),
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: widget!,
              );
            },
          );
        });
  }
}
