// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyCKhgBGrzx_POZ0SzVFzQx-lIePlK5weKE',
    appId: '1:571138215507:web:9f58da048ff987d28d80a6',
    messagingSenderId: '571138215507',
    projectId: 'flutterapp-e1c90',
    authDomain: 'flutterapp-e1c90.firebaseapp.com',
    databaseURL: 'https://flutterapp-e1c90-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterapp-e1c90.firebasestorage.app',
    measurementId: 'G-WYLL4J8CY5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuZ5etGgAuxlD_fNCNceNJ2FKS1nmbWv4',
    appId: '1:571138215507:android:98858af1d0b898e78d80a6',
    messagingSenderId: '571138215507',
    projectId: 'flutterapp-e1c90',
    databaseURL: 'https://flutterapp-e1c90-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterapp-e1c90.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKhgBGrzx_POZ0SzVFzQx-lIePlK5weKE',
    appId: '1:571138215507:web:220c1b980c74dd0f8d80a6',
    messagingSenderId: '571138215507',
    projectId: 'flutterapp-e1c90',
    authDomain: 'flutterapp-e1c90.firebaseapp.com',
    databaseURL: 'https://flutterapp-e1c90-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterapp-e1c90.firebasestorage.app',
    measurementId: 'G-5J4NJGMF65',
  );
}
