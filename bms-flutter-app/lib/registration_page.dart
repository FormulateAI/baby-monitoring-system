import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hackathon/home_page.dart';
import 'package:hackathon/user_model.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            child: Form(
              key: _formKey,
              child: Column(
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
                      helperText: "Ex: Hrushikesh Rao",
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        User user = new User(
                            fullName, yourNumber, babyName, emergencyNumber);
                        print("full name:${user.fullName}");
                        print("yor number:${user.yourNumber}");
                        print("baby name:${user.babyName}");
                        print("emergency:${user.emergencyNumber}");
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return HomePage();
                          },
                        ));
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: size.height * 0.02,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: size.height * 0.025),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
