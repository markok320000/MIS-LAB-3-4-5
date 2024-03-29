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
    apiKey: 'AIzaSyAIVTndg-t8j7PZ7DtpawtLVEhZ8BmilIA',
    appId: '1:587487646182:web:15788037b5c762dc444627',
    messagingSenderId: '587487646182',
    projectId: 'event-scheduler-40ebc',
    authDomain: 'event-scheduler-40ebc.firebaseapp.com',
    storageBucket: 'event-scheduler-40ebc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCphQWEo6c7zfKxgzjYcO5LE_SSPaSGErE',
    appId: '1:587487646182:android:50393e3ea5e729f3444627',
    messagingSenderId: '587487646182',
    projectId: 'event-scheduler-40ebc',
    storageBucket: 'event-scheduler-40ebc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoSgS-WXBKHdJBcCneAtOLQyMGgzcWrMQ',
    appId: '1:587487646182:ios:f3048becb9dd1651444627',
    messagingSenderId: '587487646182',
    projectId: 'event-scheduler-40ebc',
    storageBucket: 'event-scheduler-40ebc.appspot.com',
    iosBundleId: 'com.example.eventSchedulerProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoSgS-WXBKHdJBcCneAtOLQyMGgzcWrMQ',
    appId: '1:587487646182:ios:5cf65a6259af403f444627',
    messagingSenderId: '587487646182',
    projectId: 'event-scheduler-40ebc',
    storageBucket: 'event-scheduler-40ebc.appspot.com',
    iosBundleId: 'com.example.eventSchedulerProject.RunnerTests',
  );
}
