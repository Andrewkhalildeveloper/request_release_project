// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:request_to_release_project/my_theme.dart';
import 'package:request_to_release_project/view/home_page/home.dart';
import 'package:request_to_release_project/view/login_page/login.dart';
import 'package:request_to_release_project/view/splash_screen/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:request_to_release_project/view_model/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'firebase_options.dart';

// TODO: Add stream controller
// TODO: Define the background message handler
final messageStreamController = BehaviorSubject<RemoteMessage>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  //todo adjust flutter messaging in foreground message
  final messaging = FirebaseMessaging.instance;
  final settings = await messaging.requestPermission(
    alert: true,
    sound: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
  );
  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }
    messageStreamController.sink.add(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const topic = 'app_promotion';
  await messaging.subscribeToTopic(topic);

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => TokenProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.primaryMode,
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName: (context) => const Splash(),
        Login.routeName: (context) => const Login(),
        Home.routeName: (context) => const Home(),
      },
    );
  }
}
