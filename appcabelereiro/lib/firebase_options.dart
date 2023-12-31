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
    apiKey: 'AIzaSyD05tYDptB3pHZd9J36tqryDxzTYkS-tMs',
    appId: '1:614911566185:web:a6a66fe23ef1cbb6b99df8',
    messagingSenderId: '614911566185',
    projectId: 'app-cabelereiro',
    authDomain: 'app-cabelereiro.firebaseapp.com',
    databaseURL: 'https://app-cabelereiro-default-rtdb.firebaseio.com',
    storageBucket: 'app-cabelereiro.appspot.com',
    measurementId: 'G-856K34E670',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXBEMO0Wm-Ycs92sqbWqdoUEx3z5ZKukw',
    appId: '1:614911566185:android:09fa097027902540b99df8',
    messagingSenderId: '614911566185',
    projectId: 'app-cabelereiro',
    databaseURL: 'https://app-cabelereiro-default-rtdb.firebaseio.com',
    storageBucket: 'app-cabelereiro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFZ2XgTbIdr7e7OK2TbuQQZ7YXMdF51H0',
    appId: '1:614911566185:ios:922fc5d6253224f2b99df8',
    messagingSenderId: '614911566185',
    projectId: 'app-cabelereiro',
    databaseURL: 'https://app-cabelereiro-default-rtdb.firebaseio.com',
    storageBucket: 'app-cabelereiro.appspot.com',
    iosClientId: '614911566185-s9hftiljivpi0et72lt2cievo7b9k8oj.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcabelereiro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFZ2XgTbIdr7e7OK2TbuQQZ7YXMdF51H0',
    appId: '1:614911566185:ios:fafb7c4010dedc0ab99df8',
    messagingSenderId: '614911566185',
    projectId: 'app-cabelereiro',
    databaseURL: 'https://app-cabelereiro-default-rtdb.firebaseio.com',
    storageBucket: 'app-cabelereiro.appspot.com',
    iosClientId: '614911566185-dt2os4gpm13g4ourkdo2nn8198tbg9s3.apps.googleusercontent.com',
    iosBundleId: 'com.example.appcabelereiro.RunnerTests',
  );
}
