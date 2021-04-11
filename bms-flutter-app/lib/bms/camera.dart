import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  const Camera({
    this.cameras,
    this.setRecognitions,
    this.model,
    this.emergencyNumber,
  });

  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;
  final String emergencyNumber;
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;
  bool toDetect = true;

  @override
  void initState() {
    super.initState();
    //Checking if cameras are available
    if (widget.cameras == null || widget.cameras.length < 1) {
      print("No camera is found");
    } else {
      //Creating new camera controller
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      //Initializing the camera
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        //Starting image stream
        controller.startImageStream((image) {
          if (!isDetecting) {
            isDetecting = true;
            //Running the model on each frame
            if (widget.model == "mobileNet") {
              Tflite.detectObjectOnFrame(
                bytesList: image.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: image.height,
                imageWidth: image.width,
                imageMean: 127.5,
                imageStd: 127.5,
                numResultsPerClass: 1,
                threshold: 0.4,
              ).then((recognitions) {
                print("recogntions: $recognitions");
                //Calling the baby monitor function
                if (toDetect) {
                  babyMonitor(recognitions);
                }
                widget.setRecognitions(recognitions, image.height, image.width);
                isDetecting = false;
              });
            }
          }
        });
      });
    }
  }

  //Call the emergency number if the person(baby) is not safe
  void isSafe(double score) {
    if (score > 0.5) {
      setState(() {
        toDetect = false;
      });
      print("UNSAFE");
      callEmergency();
    } else
      print("SAFE");
  }

  void callEmergency() async {
    await FlutterPhoneDirectCaller.callNumber(widget.emergencyNumber)
        .then((value) {
      print("call done value: $value");
    });
    print("unsafe done setting true");
    sleep(Duration(seconds: 20));
    setState(() {
      toDetect = true;
    });
  }

  //Safe area checking
  double intersectionOverUnion(Map rectOne, Map rectTwo) {
    double xi1 = math.max(rectOne['x'], rectTwo['x']);
    double yi1 = math.max(rectOne['y'], rectTwo['y']);
    double xi2 =
        math.min(rectOne['x'] + rectOne['w'], rectTwo['w'] + rectTwo['x']);
    double yi2 =
        math.min(rectOne['h'] + rectOne['y'], rectTwo['h'] + rectTwo['y']);

    print("xi1:$xi1 xi2:$xi2 yi1:$yi1 yi2:$yi2");

    if ((rectOne['x'] - rectTwo['x'] > 0) || (rectOne['y'] - rectTwo['y'] <= 0))
      return 0.6;

    double innerArea = (yi2 - yi1) * (xi2 - xi1);
    double box1Area = (rectOne['w']) * (rectOne['h']);
    double box2Area = (rectTwo['w']) * (rectTwo['h']);
    double unionArea = box1Area + box2Area - innerArea;
    print(
        "inner area:$innerArea union area: $unionArea ratio: ${innerArea / unionArea}");
    return innerArea / unionArea;
  }

  //Checking if bed and person(baby) are present in the frame, if yes checking if the person(baby) is in a safe area
  void babyMonitor(List<dynamic> recognitions) {
    if (null == recognitions || recognitions.length <= 0) return;

    Map bedRectangle;
    Map personRectangle;
    for (dynamic i in recognitions) {
      if (i['detectedClass'] == "bed") {
        bedRectangle = i['rect'];
        print("got a bed rectangle: $bedRectangle");
      } else if (i['detectedClass'] == "person") {
        personRectangle = i['rect'];
        print("got a person rectangle: $personRectangle");
      } else {
        print("ntg");
      }
    }
    if (bedRectangle != null && personRectangle != null) {
      //To check if the person(baby) is in the safe area
      isSafe(intersectionOverUnion(bedRectangle, personRectangle));
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized)
      return Container();

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
