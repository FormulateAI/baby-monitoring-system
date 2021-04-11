import 'package:camera/camera.dart';
import 'package:final_hackathon/bms/bndbox.dart';
import 'package:final_hackathon/bms/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String emergencyNumber;
  //Recieving cameras to pass onto the cameras page
  HomePage({this.cameras, this.emergencyNumber});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageWidth = 0;
  int _imageHeight = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
    //selecting the model
    onSelect("mobileNet");
  }

  onSelect(String model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  //loading the model
  loadModel() async {
    String res;
    if (_model == "mobileNet") {
      res = await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt");
    }
    print("Model loaded: $_model $res");
  }

  //updating the required fileds with the latest values
  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _model == ""
          ? CircularProgressIndicator()
          : Stack(
              children: [
                Camera(
                  cameras: widget.cameras,
                  model: _model,
                  setRecognitions: setRecognitions,
                  emergencyNumber: widget.emergencyNumber,
                ),
                BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model,
                ),
              ],
            ),
    );
  }
}

// Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   MaterialButton(
//                     color: Colors.grey[900],
//                     child: Text(
//                       "mobilenet",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () => onSelect("mobileNet"),
//                   ),
//                 ],
//               ),
//             )
