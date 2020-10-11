import 'package:flutter/material.dart';
import 'package:space_invaders/Screens/HomePage.dart';
import 'package:space_invaders/Screens/IntroPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        IntroPage.id: (context) => IntroPage(),
        HomePage.id: (context) => HomePage(),
      },
      initialRoute: IntroPage.id,
    );
  }
}
