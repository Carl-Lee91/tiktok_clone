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
    apiKey: 'AIzaSyDSXPR7R9pMGuLid410wbRuIHSgQbBaKlU',
    appId: '1:773709526241:web:66c2e6a7abeb7187a473a0',
    messagingSenderId: '773709526241',
    projectId: 'carltiktok',
    authDomain: 'carltiktok.firebaseapp.com',
    storageBucket: 'carltiktok.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXYsgcrh_8X6wD3Rp34QmVhKmzpF8ow14',
    appId: '1:773709526241:android:1c59850153a2f613a473a0',
    messagingSenderId: '773709526241',
    projectId: 'carltiktok',
    storageBucket: 'carltiktok.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCk2TunZYw0nZTQjNgcnD3J4y2niMKICs4',
    appId: '1:773709526241:ios:aa1d4f0cdcee5538a473a0',
    messagingSenderId: '773709526241',
    projectId: 'carltiktok',
    storageBucket: 'carltiktok.appspot.com',
    androidClientId: '773709526241-dp7qhdg7jbmjumkapb9e74oqjpa5bc2d.apps.googleusercontent.com',
    iosClientId: '773709526241-7h27uhd5gs7ga3ebrnqr4hpvblatghnp.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}
