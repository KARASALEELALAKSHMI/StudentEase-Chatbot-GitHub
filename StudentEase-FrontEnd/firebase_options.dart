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
    apiKey: 'AIzaSyBE5_bVMt6wXa9AMdJBjBj_azGaFsipgPI',
    appId: '1:701397851639:web:81a38e264034bf3c15e2f2',
    messagingSenderId: '701397851639',
    projectId: 'stdease-9c8d6',
    authDomain: 'stdease-9c8d6.firebaseapp.com',
    storageBucket: 'stdease-9c8d6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-uSTt-DEaywqCDQtwn79dNFdpXnDjvCA',
    appId: '1:701397851639:android:2734a0f61bd7ebb015e2f2',
    messagingSenderId: '701397851639',
    projectId: 'stdease-9c8d6',
    storageBucket: 'stdease-9c8d6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAe9IrAijdBKyiL_OPm3mmWAZaYSoxXyQM',
    appId: '1:701397851639:ios:4c0037722432036215e2f2',
    messagingSenderId: '701397851639',
    projectId: 'stdease-9c8d6',
    storageBucket: 'stdease-9c8d6.firebasestorage.app',
    iosBundleId: 'com.example.figdesign',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAe9IrAijdBKyiL_OPm3mmWAZaYSoxXyQM',
    appId: '1:701397851639:ios:4c0037722432036215e2f2',
    messagingSenderId: '701397851639',
    projectId: 'stdease-9c8d6',
    storageBucket: 'stdease-9c8d6.firebasestorage.app',
    iosBundleId: 'com.example.figdesign',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBE5_bVMt6wXa9AMdJBjBj_azGaFsipgPI',
    appId: '1:701397851639:web:52230552b368770815e2f2',
    messagingSenderId: '701397851639',
    projectId: 'stdease-9c8d6',
    authDomain: 'stdease-9c8d6.firebaseapp.com',
    storageBucket: 'stdease-9c8d6.firebasestorage.app',
  );
}
