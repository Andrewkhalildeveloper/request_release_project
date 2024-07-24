import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:request_to_release_project/my_theme.dart';
import 'package:request_to_release_project/view/home_page/home.dart';
import 'package:request_to_release_project/view/login_page/login.dart';
import 'package:request_to_release_project/view/splash_screen/splash.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: MyTheme.primaryMode,
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.routeName,
      routes: {
        Splash.routeName :(context)=>const Splash(),
        Login.routeName : (context)=>const Login(),
        Home.routeName : (context)=>const Home(),
      },
    );
  }
}
