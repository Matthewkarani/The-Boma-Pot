import 'package:flutter/material.dart';
import 'package:recipe_recommendation_front_end/pages/LandingPage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(), // Start with LandingPage.dart
    );
  }
}
