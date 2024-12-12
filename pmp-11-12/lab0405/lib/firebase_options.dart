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
        return macos;
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
    apiKey: 'AIzaSyCt88j9YsCcwpHwbsLD0cRHDYn87lZPFCM',
    appId: '1:943408485450:web:a6a8d88f3cede11836c2b3',
    messagingSenderId: '943408485450',
    projectId: 'fir-lab-b099b',
    authDomain: 'fir-lab-b099b.firebaseapp.com',
    storageBucket: 'fir-lab-b099b.firebasestorage.app',
    measurementId: 'G-T9R97YB9PB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiGNt9gfrdyNBhDQPlJDsysjApS0drb8U',
    appId: '1:943408485450:android:6f87ad3bcbb0182e36c2b3',
    messagingSenderId: '943408485450',
    projectId: 'fir-lab-b099b',
    storageBucket: 'fir-lab-b099b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxK-9cgL8lUDBYb9NYjRSuLegJpGTkSMc',
    appId: '1:943408485450:ios:c32a953f5de9331736c2b3',
    messagingSenderId: '943408485450',
    projectId: 'fir-lab-b099b',
    storageBucket: 'fir-lab-b099b.firebasestorage.app',
    iosBundleId: 'com.example.lab0405',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxK-9cgL8lUDBYb9NYjRSuLegJpGTkSMc',
    appId: '1:943408485450:ios:c32a953f5de9331736c2b3',
    messagingSenderId: '943408485450',
    projectId: 'fir-lab-b099b',
    storageBucket: 'fir-lab-b099b.firebasestorage.app',
    iosBundleId: 'com.example.lab0405',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCt88j9YsCcwpHwbsLD0cRHDYn87lZPFCM',
    appId: '1:943408485450:web:fe2d0c90e542ff1c36c2b3',
    messagingSenderId: '943408485450',
    projectId: 'fir-lab-b099b',
    authDomain: 'fir-lab-b099b.firebaseapp.com',
    storageBucket: 'fir-lab-b099b.firebasestorage.app',
    measurementId: 'G-L33Q9NHY8W',
  );
}
