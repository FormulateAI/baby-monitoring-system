import 'package:camera/camera.dart';
import 'package:final_hackathon/bms/home_page.dart';
import 'package:final_hackathon/ui/description.dart';
import 'package:final_hackathon/ui/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegistrationPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  RegistrationPage({this.cameras});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool toShow = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Field values
    String fullName;
    String babyName;
    String yourNumber;
    String emergencyNumber;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: toShow
                      ? Description()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Registration",
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: size.height * 0.06,
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Text(
                              "All fields are mandatory.",
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: size.height * 0.015,
                              ),
                            ),
                            SizedBox(height: size.height * 0.05),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: "Full Name",
                                hintText: "Enter your full name",
                                border: OutlineInputBorder(),
                                helperText: "Ex: Thirumalesh",
                              ),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'This field cannot be empty!';
                                else
                                  return null;
                              },
                              onSaved: (String value) {
                                fullName = value;
                              },
                            ),
                            SizedBox(height: size.height * 0.05),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: "Phone Number",
                                hintText: "Enter your phone number",
                                helperText: "Ex: 1234567890",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'This field cannot be empty!';
                                else if (value.length < 10)
                                  return 'Please check your number';
                                else
                                  return null;
                              },
                              onSaved: (String value) {
                                yourNumber = value;
                              },
                            ),
                            SizedBox(height: size.height * 0.05),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.child_care),
                                labelText: "Baby's Name",
                                hintText: "Enter your baby's name",
                                helperText: "Ex: Aishwarya",
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.name,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'This field cannot be empty!';
                                else
                                  return null;
                              },
                              onSaved: (String value) {
                                babyName = value;
                              },
                            ),
                            SizedBox(height: size.height * 0.05),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.warning),
                                labelText: "Emergency Number",
                                hintText: "Enter emergency number",
                                helperText:
                                    "Call will be given to this number in case of emergency",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'This field cannot be empty!';
                                else if (value.length < 10)
                                  return 'Please check your number';
                                else
                                  return null;
                              },
                              onSaved: (String value) {
                                emergencyNumber = value;
                              },
                            ),
                            SizedBox(height: size.height * 0.055),
                            //Submit button
                          ],
                        ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (toShow) {
                      print("to show pressd");
                      setState(() {
                        toShow = false;
                      });
                    } else {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        User user = new User(
                            fullName, yourNumber, babyName, emergencyNumber);
                        print("full name:${user.fullName}");
                        print("yor number:${user.yourNumber}");
                        print("baby name:${user.babyName}");
                        print("emergency:${user.emergencyNumber}");
                        //Pushing to HomePage
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage(
                              cameras: widget.cameras,
                              emergencyNumber: emergencyNumber,
                            );
                          },
                        ));
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: size.height * 0.02,
                    ),
                    child: Text(
                      toShow ? "Next" : "Submit",
                      style: TextStyle(fontSize: size.height * 0.025),
                    ),
                  ),
                ),
                SizedBox(height: 25)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
