import 'dart:async';
import 'package:flutter/material.dart';
import 'package:request_to_release_project/view/login_page/login.dart';

class Splash extends StatefulWidget {
  static const String routeName = 'splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: const Color(0xfff3efee),
        ),
        Image.asset(
          'assets/images/pharmacy-symbol.png',
          fit: BoxFit.fill,
        )
      ],
    );
  }
}
