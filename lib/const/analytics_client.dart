import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  Analytics._();

  static final instance = Analytics._();
  static final _analytics = FirebaseAnalytics.instance;
  // static final _fBAnalytics = FacebookAppEvents();
  static final _observer = FirebaseAnalyticsObserver(analytics: _analytics);

  FirebaseAnalyticsObserver get observer => _observer;

  Future<void> setAnalyticsCollectionEnabled(bool val) async {
    await _analytics.setAnalyticsCollectionEnabled(val);
    // await _fBAnalytics.setAdvertiserTracking(enabled: val);
    // await _fBAnalytics.setAutoLogAppEventsEnabled(val);
  }

  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
    // await _fBAnalytics.logEvent(name: 'app_open');
  }

  Future<void> logLogin() async {
    await _analytics.logLogin(loginMethod: 'Phone');
    // await _fBAnalytics.logEvent(
    //   name: 'login',
    //   parameters: {
    //     'method': 'Phone',
    //   },
    // );
  }

  Future<void> logSignUp() async {
    await _analytics.logSignUp(signUpMethod: 'Phone');
    // await _fBAnalytics.logEvent(
    //   name: 'sign_up',
    //   parameters: {
    //     'method': 'Phone',
    //   },
    // );
  }

  Future<void> setUserId({required int userId}) async {
    await _analytics.setUserId(id: '$userId');
    // await _fBAnalytics.setUserID('$userId');
  }

  Future<void> logOrder({
    required num? userId,
    required num? providerId,
    required num? orderId,
  }) async {
    await _analytics.logEvent(name: 'new order', parameters: {
      'userId': userId,
      'providerId': providerId,
      'orderId': orderId,
    });
    // await _fBAnalytics.logEvent(name: 'new order', parameters: {
    //   'userId': userId,
    //   'providerId': providerId,
    //   'orderId': orderId,
    // });
  }

  // Future<void> logPurchase({
  //   String? coupon,
  //   required num courseId,
  //   required num userId,
  //   required num value,
  //   num? discount,
  //   String? phone,
  // }) async {
  //   await _analytics.logPurchase(
  //     currency: 'EGP',
  //     coupon: coupon,
  //     value: value.toDouble(),
  //     items: [1]
  //         .map(
  //           (product) => AnalyticsEventItem(
  //
  //           ),
  //         )
  //         .toList(),
  //   );
  // }

  Future<void> logPhoneClick({
    required num? userId,
    required num? providerId,
    required String? phone,
  }) async {
    await _analytics.logEvent(name: 'Phone Click', parameters: {
      'userId': userId,
      'providerId': providerId,
      'phone': phone,
    });
    // await _fBAnalytics.logEvent(name: 'Phone Click', parameters: {
    //   'userId': userId,
    //   'providerId': providerId,
    //   'phone': phone,
    // });
  }

  Future<void> resetAnalytics() async {
    await _analytics.resetAnalyticsData();
    // await _fBAnalytics.clearUserData();
  }
}
