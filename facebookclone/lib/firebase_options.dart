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
    apiKey: 'AIzaSyAN_jdpP_F3wbL2O9sMV4b-5J2EaCWsguI',
    appId: '1:566106420606:web:235ae0d9fccea1ae82ef2f',
    messagingSenderId: '566106420606',
    projectId: 'facebookclone-89d2d',
    authDomain: 'facebookclone-89d2d.firebaseapp.com',
    storageBucket: 'facebookclone-89d2d.appspot.com',
    measurementId: 'G-9QXTKYM7XB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrAD4Mwcjh50cvoaeMKEOKJVgxRVOvYAk',
    appId: '1:566106420606:android:be5cb160845fbf0282ef2f',
    messagingSenderId: '566106420606',
    projectId: 'facebookclone-89d2d',
    storageBucket: 'facebookclone-89d2d.appspot.com',
  );
}