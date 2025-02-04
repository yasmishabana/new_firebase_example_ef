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
    apiKey: 'AIzaSyBsZktAXQjc4PftCdPBGitIsW9B38WjmnE',
    appId: '1:495719619600:web:bb1859720eabc48fdfbe95',
    messagingSenderId: '495719619600',
    projectId: 'otpverification-36b47',
    authDomain: 'otpverification-36b47.firebaseapp.com',
    storageBucket: 'otpverification-36b47.appspot.com',
    measurementId: 'G-3QE3YDSE5F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0fr9BPpyLzhbzixEl2WWa2NKerOlrZ5A',
    appId: '1:495719619600:android:1a9b732890f20fbbdfbe95',
    messagingSenderId: '495719619600',
    projectId: 'otpverification-36b47',
    storageBucket: 'otpverification-36b47.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_1I2GAPxxhMHnBZauEGIU2cKvNQjiV0Q',
    appId: '1:495719619600:ios:0f2ce9fb592583c7dfbe95',
    messagingSenderId: '495719619600',
    projectId: 'otpverification-36b47',
    storageBucket: 'otpverification-36b47.appspot.com',
    iosBundleId: 'com.example.newFirebaseExampleEf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_1I2GAPxxhMHnBZauEGIU2cKvNQjiV0Q',
    appId: '1:495719619600:ios:0f2ce9fb592583c7dfbe95',
    messagingSenderId: '495719619600',
    projectId: 'otpverification-36b47',
    storageBucket: 'otpverification-36b47.appspot.com',
    iosBundleId: 'com.example.newFirebaseExampleEf',
  );
}
