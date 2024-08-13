import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;
// import 'dart:math';

import 'package:beauty_queen/const/vars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../View/brands/branddetail_screen.dart';
import '../View/brands/brands_screen.dart';
import '../View/categories/filter_screen2.dart';
import '../View/discount/discounts_screen.dart';
import '../View/gifts/GuidanceScreen.dart';
import '../View/magazine/magazine_screen.dart';
import '../View/notification/notification_screen.dart';
import '../View/offers/beautypharmacyscreen.dart';
import '../View/product_profile/products_screen.dart';
import '../controller/AlKasam_controller/alkasam_controller.dart';
import '../controller/home_controller/home_controller.dart';
import '../controller/product_controller/product_profile_controller_provider.dart';
import 'api_connrction/user_data_apis.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('firebaseMessagingBackgroundHandler:$message');
  // NotificationHelper.onBgNotificationOpen(json.encode(message.data));
}

class NotificationHelper {
  // Constructor
  NotificationHelper({this.fcmOnMessage}) {
    _initFCM();
  }

  // Clients.
  static final _fcmNotify = FirebaseMessaging.instance;
  static final _localNotify = FlutterLocalNotificationsPlugin();

  // Functions.
  final Function? fcmOnMessage;

  // Vars
  bool _init = false;

  // Public Methods
  Future<void> subscribeToTopic(String topic) async {
    await _fcmNotify.subscribeToTopic("topic_$topic");
  }

  Future<void> unSubscribeToTopic(String topic) async {
    await _fcmNotify.unsubscribeFromTopic("topic_$topic");
  }

  // Private Methods
  _initFCM() async {
    if (_init) {
      return;
    } else {
      await _fcmNotify.subscribeToTopic('all');
      await _fcmNotify.setAutoInitEnabled(true);

      // Get Token and just Print it.
      await _saveFCMToken();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      onTokenRefresh();

      // Init Listen for Notifications.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // if (kDebugMode) {
        print("methodName: 'FirebaseMessaging@onMessage',\n"
            "fileName: 'fcm_manager.dart',\n"
            "response: ${message.data},\n");
        // }
        //
        if (fcmOnMessage != null) fcmOnMessage!(message);
        //
        showNotification(message);
      });
      // Request Permissions for IOS Only.
      await _fcmNotify.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      void onDidReceiveLocalNotification(
          int? id, String? title, String? body, String? payload) async {}

      // Init Local Notifications Settings.
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification,
      );
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );
      // await _localNotify.initialize(initializationSettings,
      //     onDidReceiveBackgroundNotificationResponse: onNotificationOpen,
      //     onDidReceiveNotificationResponse: onNotificationOpen);
      _init = true;
    }
  }

  Future<void> _saveFCMToken() async {
    final token = await _fcmNotify.getToken();
    if (kDebugMode) debugPrint("_fcmToken: $token");
  }

  void handleMessage(RemoteMessage message) {
    print("Notification Data: ${message.data}");
    try {
      String? page = message.data['page'];
      print(
          "Notification Data:$page - ${(page != null)} - ${(page == LinkTypes.product)}");

      if (page != null) {
        final HomeController _controllerHome = Get.put(HomeController());

        _controllerHome.getHomeDataController();

        if (page == LinkTypes.product) {
          String? key = message.data['value'];
          print('page:${page}, key:$key');

          Get.off(() => ChangeNotifierProvider(
              create: (context) => ProductProfileControllerProvider(),
              child: ItemProfilePage(itemId: int.parse(key ?? '0'))));
        } else if (page == LinkTypes.category) {
          String? key = message.data['value'];
          print('page:${page}, key:$key');

          AlkasamController controller = Get.put(AlkasamController());
          controller.updateCurrentCategoryId(
              newId: int.parse(key ?? '0'), getChild: null);
          // Get.to();
          Get.off(() => FliterScreen2(categoryId: int.parse(key ?? '0')));
        } else if (page == LinkTypes.brand) {
          String? key = message.data['value'];
          print('page:${page}, key:$key');

          Get.off(() => BrandDetailScreen(brandId: int.parse(key ?? '0')));
        } else if (page == LinkTypes.brandsPage) {
          Get.off(
            () => const BrandScreen(),
          );
        } else if (page == LinkTypes.sales) {
          Get.off(() => const DiscountScreen());
        } else if (page == LinkTypes.magazine) {
          Get.off(() => const MagazineScreen());
        } else if (page == LinkTypes.gifts) {
          Get.off(() => const GuidanceScreen());
        } else if (page == LinkTypes.offers) {
          Get.off(() => const BeautyPharmacyScreen());
        }
      }
    } catch (e, s) {
      log('Manual Reporting Crash $e');
    }
    // Perform any other action you want when the notification is opened
  }

  // static Future<void> onBgNotificationOpen(String? x) async {
  //   try {
  //     final message = json.decode(x!);
  //     print('message_notification--:${message}');
  //     print('message_notification--:${x}');
  //     String? page2 = message['page'];
  //     print('message_notification--:${(page2 == LinkTypes.magazine)}, $page2');
  //
  //     if (page2 != null) {
  //       final HomeController _controllerHome = Get.put(HomeController());
  //
  //       _controllerHome.getHomeDataController();
  //
  //       if (page2 == '"${LinkTypes.product}"' || page2 == LinkTypes.product) {
  //         String? key = message['value'];
  //         print('page:${page2}, key:$key');
  //
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => ChangeNotifierProvider(
  //                 create: (context) => ProductProfileControllerProvider(),
  //                 child: ItemProfilePage(itemId: int.parse(key ?? '0'))),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.category) {
  //         String? key = message['value'];
  //         print('page:${page2}, key:$key');
  //
  //         AlkasamController controller = Get.put(AlkasamController());
  //         controller.updateCurrentCategoryId(
  //             newId: int.parse(key ?? '0'), getChild: null);
  //         // Get.to();
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => FliterScreen2(
  //               categoryId: int.parse(key ?? '0'),
  //             ),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.brand) {
  //         String? key = message['value'];
  //         print('page:${page2}, key:$key');
  //
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => BrandDetailScreen(
  //               brandId: int.parse(key ?? '0'),
  //             ),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.brandsPage) {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const BrandScreen(),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.sales) {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const DiscountScreen(),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.magazine) {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const MagazineScreen(),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.gifts) {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const GuidanceScreen(),
  //           ),
  //         );
  //       } else if (page2 == LinkTypes.offers) {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const BeautyPharmacyScreen(),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e, s) {
  //     log('Manual Reporting Crash $e');
  //   }
  // }
  //
  // static Map convertPayload(String payload) {
  //   final String payload0 = payload.substring(1, payload.length - 1);
  //   List<String> split = [];
  //   payload0.split(",").forEach((String s) => split.addAll(s.split(":")));
  //   Map mapped = {};
  //   for (int i = 0; i < split.length + 1; i++) {
  //     if (i % 2 == 1) {
  //       mapped.addAll({split[i - 1].trim().toString(): split[i].trim()});
  //     }
  //   }
  //   return mapped;
  // }

  // static Future<void> onNotificationOpen(NotificationResponse? response) async {
  //   try {
  //     print('message_notification00:${response}');
  //     final Map _data = convertPayload(response!.payload!);
  //     print('message_notification:${_data}');
  //     print('message_notification_page:${_data.containsKey('"page"')}');
  //     print('message_notification_page:${_data}');
  //     String? page = _data['"page"'];
  //     if (page != null) {
  //       final HomeController _controllerHome = Get.put(HomeController());
  //
  //       _controllerHome.getHomeDataController();
  //
  //       if (page == '"${LinkTypes.product}"') {
  //         String? key = _data['"value"'].toString().split('"')[1];
  //         print('page:${page}, key:$key');
  //
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => ChangeNotifierProvider(
  //                 create: (context) => ProductProfileControllerProvider(),
  //                 child: ItemProfilePage(itemId: int.parse(key ?? '0'))),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.category}"') {
  //         String? key = _data['"value"'].toString().split('"')[1];
  //         print('page:${page}, key:$key');
  //
  //         AlkasamController controller = Get.put(AlkasamController());
  //         controller.updateCurrentCategoryId(
  //             newId: int.parse(key ?? '0'), getChild: null);
  //         // Get.to();
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => FliterScreen2(
  //               categoryId: int.parse(key ?? '0'),
  //             ),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.brand}"') {
  //         String? key = _data['"value"'].toString().split('"')[1];
  //         print('page:${page}, key:$key');
  //
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => BrandDetailScreen(
  //               brandId: int.parse(key ?? '0'),
  //             ),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.brandsPage}"') {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const BrandScreen(),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.sales}"') {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const DiscountScreen(),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.magazine}"') {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const MagazineScreen(),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.gifts}"') {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const GuidanceScreen(),
  //           ),
  //         );
  //       } else if (page == '"${LinkTypes.offers}"') {
  //         Navigator.of(Get.context!).push(
  //           CupertinoPageRoute(
  //             builder: (context) => const BeautyPharmacyScreen(),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e, s) {
  //     log('Manual Reporting Crash $e');
  //   }
  // }

  // Helper Functions
  void showNotification(RemoteMessage payload) async {
    await _initFCM();

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'BAChannelID',
      'BAChannelName',
      channelDescription: 'BAChanelDescription',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _localNotify.show(
      Random().nextInt(999),
      payload.notification!.title ?? '',
      payload.notification!.body ?? '',
      platformChannelSpecifics,
      payload: json.encode(payload.data),
    );
  }

  Future<void> onTokenRefresh() async {
    print('_onTokenRefresh');
    // _fcmNotify.onTokenRefresh.listen((String token) async {
    UserDataApis().addDevice();
    // });
  }
}
