import 'package:beauty_queen/View/welcome/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'const/app_colors.dart';
import 'const/notification.dart';
import 'const/styles.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  NotificationHelper();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  FirebasePerformance.instance.setPerformanceCollectionEnabled(!kDebugMode);
  // Analytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);

  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar')],
      useOnlyLangCode: true,
      path: 'assets/langs',
      fallbackLocale: const Locale('ar'),
      child: const MyApp()));
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
            title: 'Beauty Queen',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.kWhiteColor,
                useMaterial3: true,
                fontFamily: kTheArabicSansLight),
            home: const SplashScreen(),
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
