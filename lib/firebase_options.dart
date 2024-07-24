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
        return ios;
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
    apiKey: 'AIzaSyCOz9LGrp_plo7RAWZEl90lqJOM7rx4c8I',
    appId: '1:643150063544:web:aac1b8aff8860978e9914d',
    messagingSenderId: '643150063544',
    projectId: 'tracking-app-82f75',
    authDomain: 'tracking-app-82f75.firebaseapp.com',
    storageBucket: 'tracking-app-82f75.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALKq0ntzrEXXh3-ll0LIX_8_cTZU-EhKQ',
    appId: '1:643150063544:android:4bb6ba4e5280667be9914d',
    messagingSenderId: '643150063544',
    projectId: 'tracking-app-82f75',
    storageBucket: 'tracking-app-82f75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3IEkGP8AaebA7QjC849QWkxm1bSuIjl4',
    appId: '1:643150063544:ios:092b5071c0bf5572e9914d',
    messagingSenderId: '643150063544',
    projectId: 'tracking-app-82f75',
    storageBucket: 'tracking-app-82f75.appspot.com',
    iosBundleId: 'com.example.tracing',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOz9LGrp_plo7RAWZEl90lqJOM7rx4c8I',
    appId: '1:643150063544:web:73a3945d56327a92e9914d',
    messagingSenderId: '643150063544',
    projectId: 'tracking-app-82f75',
    authDomain: 'tracking-app-82f75.firebaseapp.com',
    storageBucket: 'tracking-app-82f75.appspot.com',
  );
}
