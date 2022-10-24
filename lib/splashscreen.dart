import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'home.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('images/movie.png'),
      title: Text(
        "PPB Modul 4",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 45, 75, 173),
      showLoader: true,
      loadingText: Text("Loading..."),
      loaderColor: Colors.white,
      navigator: HomePage(),
      durationInSeconds: 5,);
  }
}