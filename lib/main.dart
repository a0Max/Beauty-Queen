import 'package:beauty_queen/View/splash_screen.dart';
import 'package:beauty_queen/const/colors.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'View/home/bottom_nav_screen.dart';
import 'main2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar')],
      useOnlyLangCode: true,
      path: 'assets/langs',
      fallbackLocale: const Locale('ar'),
      child:const MyApp()));
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              scaffoldBackgroundColor: kWhiteColor,
              useMaterial3: true,
            ),
            // home: SplashScreen(),
            home: MyHomePage(),

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
