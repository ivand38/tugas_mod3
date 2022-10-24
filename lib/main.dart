import 'package:flutter/material.dart';
import 'package:modul3/kelompok.dart';
import 'package:modul3/splashscreen.dart';
 
import 'detail.dart';
import 'home.dart';
 
void main() async {
  runApp(const AnimeApp());
}
 
class AnimeApp extends StatelessWidget {
  const AnimeApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/':(context) => const SplashScreenPage(),
        '/home': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(item: 0, title: '', score:0, image:'',synopsis: '',),
        '/kelompok':(context) => const KelompokPage()
      },
    );
  }
}
