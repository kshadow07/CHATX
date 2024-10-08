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
    apiKey: 'AIzaSyAngNkonZDW86H_SvTiFcyT8XelboekUuw',
    appId: '1:344920323074:web:5ee8a9a7fba1c92292e31b',
    messagingSenderId: '344920323074',
    projectId: 'chat-x-4d955',
    authDomain: 'chat-x-4d955.firebaseapp.com',
    storageBucket: 'chat-x-4d955.appspot.com',
    measurementId: 'G-QN6ECR8SX8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDL6HaXj7jB0KoDq7-XA5mrHLXYMi2PrEs',
    appId: '1:344920323074:android:448365190b2ddd4b92e31b',
    messagingSenderId: '344920323074',
    projectId: 'chat-x-4d955',
    storageBucket: 'chat-x-4d955.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDa6s2oSZ01QfEod4rfoYpeYzcuG7V9kzw',
    appId: '1:344920323074:ios:8dea3e172b07840092e31b',
    messagingSenderId: '344920323074',
    projectId: 'chat-x-4d955',
    storageBucket: 'chat-x-4d955.appspot.com',
    iosBundleId: 'shadow07.com.chtx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDa6s2oSZ01QfEod4rfoYpeYzcuG7V9kzw',
    appId: '1:344920323074:ios:8dea3e172b07840092e31b',
    messagingSenderId: '344920323074',
    projectId: 'chat-x-4d955',
    storageBucket: 'chat-x-4d955.appspot.com',
    iosBundleId: 'shadow07.com.chtx',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAngNkonZDW86H_SvTiFcyT8XelboekUuw',
    appId: '1:344920323074:web:951999512e0e887b92e31b',
    messagingSenderId: '344920323074',
    projectId: 'chat-x-4d955',
    authDomain: 'chat-x-4d955.firebaseapp.com',
    storageBucket: 'chat-x-4d955.appspot.com',
    measurementId: 'G-CGRFENK1JT',
  );
}
