import 'package:day_track/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; //for date format

class RegistrationPage extends StatefulWidget {
  static const String id = 'RegistrationPage';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String email;
  String password;
  String password2;
  String contactnum;
  String name;
  final auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  Future _showAlert(BuildContext context, String message, String action) async {
    return showDialog(
        builder: (context) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19)),
              title: new Text(message),
              actions: <Widget>[
                // ignore: deprecated_member_use
                new FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: new Text(action))
              ],
            ),
        context: context);
  }

  String now;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text(''),
      // ),
      body: SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(
                      'Create an\nAccount',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: 45,
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: 'Full Name',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: ' Email Address',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    contactnum = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: ' Contact Number',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: 'Password',
                  hintText: 'Atleast 6 characters',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "password cannot be empty";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    password2 = value;
                  });
                },
                decoration: new InputDecoration(
                  labelText: 'Confirm Password',
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "password cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: new MaterialButton(
                  onPressed: () {
                    if (password2 == "" ||
                        password == "" ||
                        email == "" ||
                        contactnum == "") {
                      _showAlert(context, 'Enter All the fields', 'Ok');
                    } else {
                      if (password == password2) {
                        Navigator.pushNamed(context, Loginpage.id);
                      } else {
                        _showAlert(
                            context, 'Passwords are not same', 'Check Now');
                      }
                    }
                    createUser();
                  },
                  height: 46,
                  minWidth: 130,
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 17),
                  ),
                  textColor: Colors.white,
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future createUser() async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        final FirebaseUser user = await auth.currentUser();
        final userid = user.uid;

        // saving data to firebase
        //
        // _firestore.collection('store_details').document(userid).setData({

        // });
        _firestore.collection('user_details').document(userid).setData({
          'email': email,
          'contact_no': contactnum,
          'name': name,
          'joinedon': now = DateFormat("dd-MM-yyyy").format(DateTime.now()),
        });
        _showAlert(context, 'Succesfully Registered ', 'Ok');

        Navigator.pushNamed(context, Loginpage.id);
      }
    } catch (e) {
      _showAlert(
          context, 'Allready Registered.\n Use another email id', 'Retry Now');
    }
  }
}
