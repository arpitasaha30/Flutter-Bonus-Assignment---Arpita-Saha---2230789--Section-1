// File generated normally by the FlutterFire CLI (`flutterfire configure`).
//
// *** THIS IS A PLACEHOLDER ***
// The values below are NOT real. Claude cannot create a Firebase project or
// generate real API keys on your behalf, since that requires your own
// Google account. Follow SETUP_INSTRUCTIONS.md to run:
//
//   dart pub global activate flutterfire_cli
//   flutterfire configure
//
// from the project root, logged in with your own Google account. That
// command talks to YOUR Firebase project and will overwrite this exact file
// with your real, working configuration for every platform automatically.
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'run `flutterfire configure` again to add this platform, or '
          'use the web build instead.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // --- REPLACE EVERYTHING BELOW BY RUNNING `flutterfire configure` ---

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAbiQviuQFAjXUoduZ31gp07qNszoGLmIY',
    appId: '1:568030481454:web:24936772b9a3518bc063bf',
    messagingSenderId: '568030481454',
    projectId: 'cse464-coffee-app',
    authDomain: 'cse464-coffee-app.firebaseapp.com',
    storageBucket: 'cse464-coffee-app.firebasestorage.app',
    measurementId: 'G-H03M40HVL7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqXFNF9tLSwEQb34dMMxLKTKwU2fX_KwQ',
    appId: '1:568030481454:android:f0a0e69ff60443bac063bf',
    messagingSenderId: '568030481454',
    projectId: 'cse464-coffee-app',
    storageBucket: 'cse464-coffee-app.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnw8-rnbQoJtSVBZKb5fiCpoAepWtkJIs',
    appId: '1:568030481454:ios:9024e874787a2b46c063bf',
    messagingSenderId: '568030481454',
    projectId: 'cse464-coffee-app',
    storageBucket: 'cse464-coffee-app.firebasestorage.app',
    iosBundleId: 'com.example.summerIubApp',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnw8-rnbQoJtSVBZKb5fiCpoAepWtkJIs',
    appId: '1:568030481454:ios:9024e874787a2b46c063bf',
    messagingSenderId: '568030481454',
    projectId: 'cse464-coffee-app',
    storageBucket: 'cse464-coffee-app.firebasestorage.app',
    iosBundleId: 'com.example.summerIubApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAbiQviuQFAjXUoduZ31gp07qNszoGLmIY',
    appId: '1:568030481454:web:90a494181b8fade8c063bf',
    messagingSenderId: '568030481454',
    projectId: 'cse464-coffee-app',
    authDomain: 'cse464-coffee-app.firebaseapp.com',
    storageBucket: 'cse464-coffee-app.firebasestorage.app',
    measurementId: 'G-D6EGH50T1C',
  );
}
