import 'package:flutter/material.dart';
import 'package:hackathon/registration_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hackthon",
      home: RegistrationPage(),
    );
  }
}
