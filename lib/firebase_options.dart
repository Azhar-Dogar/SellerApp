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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCO5Lir6G2rszPcsR-qwOhfk5vYLg_UrHU',
    appId: '1:768995689619:web:7d7de41e011b951440b966',
    messagingSenderId: '768995689619',
    projectId: 'eshop-ecd09',
    authDomain: 'eshop-ecd09.firebaseapp.com',
    storageBucket: 'eshop-ecd09.appspot.com',
    measurementId: 'G-YPCJE34CK1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5T1eGeplm2za9F74HE4rHsU3zketb4C4',
    appId: '1:768995689619:android:5ddd68078495c6d140b966',
    messagingSenderId: '768995689619',
    projectId: 'eshop-ecd09',
    storageBucket: 'eshop-ecd09.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAagosfit5ZZslu3_Xt1svP1iGs_xNMKh0',
    appId: '1:768995689619:ios:9e5947496968f3a440b966',
    messagingSenderId: '768995689619',
    projectId: 'eshop-ecd09',
    storageBucket: 'eshop-ecd09.appspot.com',
    iosBundleId: 'eshop.seller.multivendor',
  );
}
