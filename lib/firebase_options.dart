// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgO1csL-ElHWZDxnNneI-qWMjjwtBYL0U',
    appId: '1:149808100906:web:108d9fdf723c64980c7553',
    messagingSenderId: '149808100906',
    projectId: 'beauty-queen-b415e',
    authDomain: 'beauty-queen-b415e.firebaseapp.com',
    storageBucket: 'beauty-queen-b415e.appspot.com',
    measurementId: 'G-D4FK8FFE34',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBZsN62nlw65ATdCpWGXLYdgXX0kA4qFE',
    appId: '1:149808100906:android:a39ce5ae4f5c9ffd0c7553',
    messagingSenderId: '149808100906',
    projectId: 'beauty-queen-b415e',
    storageBucket: 'beauty-queen-b415e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrP5elUt9I3WmSIyVthu4qVG01jJg8b4I',
    appId: '1:149808100906:ios:d7f3838b5b334d600c7553',
    messagingSenderId: '149808100906',
    projectId: 'beauty-queen-b415e',
    storageBucket: 'beauty-queen-b415e.appspot.com',
    androidClientId: '149808100906-o0o1s4ip6q2qllbl37dgql62o98tir94.apps.googleusercontent.com',
    iosClientId: '149808100906-eh70sisu8ndkec8m14mmt8fkvbsrot6d.apps.googleusercontent.com',
    iosBundleId: 'com.beauty.greatbeautyQueen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrP5elUt9I3WmSIyVthu4qVG01jJg8b4I',
    appId: '1:149808100906:ios:2e8001ccafb182910c7553',
    messagingSenderId: '149808100906',
    projectId: 'beauty-queen-b415e',
    storageBucket: 'beauty-queen-b415e.appspot.com',
    androidClientId: '149808100906-o0o1s4ip6q2qllbl37dgql62o98tir94.apps.googleusercontent.com',
    iosClientId: '149808100906-4qhajedfa9dpq0etajnq2olsf1ek42fe.apps.googleusercontent.com',
    iosBundleId: 'com.example.beautyQueen.RunnerTests',
  );
}
