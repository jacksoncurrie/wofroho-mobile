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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC6uivZXgTM0GqzqseXuQecV4JJr4tqUI',
    appId: '1:1020399568822:android:366451e631481ca7c72317',
    messagingSenderId: '1020399568822',
    projectId: 'wofroho-1e684',
    storageBucket: 'wofroho-1e684.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWS2_98l0QWXZYi5UNpItsu5QpKE1qL5A',
    appId: '1:1020399568822:ios:7cea95b27cbda7d5c72317',
    messagingSenderId: '1020399568822',
    projectId: 'wofroho-1e684',
    storageBucket: 'wofroho-1e684.appspot.com',
    androidClientId: '1020399568822-39ruivevh5jqb5og2j993htbjpjst215.apps.googleusercontent.com',
    iosClientId: '1020399568822-t654d4abl6jsq6s5dlff35u3g5c0pui8.apps.googleusercontent.com',
    iosBundleId: 'com.wofroho.app',
  );
}