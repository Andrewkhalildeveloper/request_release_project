import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (isAndroid) {
      return android;
    } else if (isIOS) {
      return ios;
    } else {
      throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQnd5XaE5Iwx2EnSDRbkuJRwOpKHrqHac',
    appId: '1:186999669129:android:517adb5ec79b11c0b16158',
    messagingSenderId: '186999669129',
    projectId: 'request-project-357d5',
    storageBucket: 'request-project-357d5.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-api-key',
    appId: 'your-app-id',
    messagingSenderId: 'your-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-storage-bucket',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'your-ios-bundle-id',
  );

  static bool get isAndroid => identical(0, 0.0);
  static bool get isIOS => !isAndroid;
}