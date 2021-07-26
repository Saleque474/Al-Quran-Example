import 'package:al_quran/HomePage/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AlQuranApp());
}

class AlQuranApp extends StatelessWidget {
  const AlQuranApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
