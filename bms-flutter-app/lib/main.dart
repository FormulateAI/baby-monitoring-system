import 'dart:async';
import 'package:final_hackathon/ui/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

//Detecting and storing all the available cameras
Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

//First page is registration page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BABY MONITORING SYSTEM',
      home: RegistrationPage(
        cameras: cameras,
      ),
    );
  }
}
