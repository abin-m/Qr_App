import 'package:day_track/screens/dashboard_admin.dart';
import 'package:day_track/screens/dashboard_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:day_track/screens/dashboard_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Loginpage extends StatefulWidget {
  static const String id = 'Login_page';
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  SharedPreferences localStorage;
  final auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String email;
  String password;
  bool showspinner = false;

  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('Cancel'))
          ],
        ));
  }

  //SHARED PREFERENCES INITIALIZATION
  Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text(''),
      // ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 120,
                ),
                Image(
                  image: AssetImage('images/login.png'),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    )
                  ],
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
                    labelText: ' Email',
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
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Password',
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
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: new MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showspinner = true;
                      });
                      try {
                        final user = await auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          final FirebaseUser user = await auth.currentUser();
                          final userid = user.uid;
                          try {
                            DocumentSnapshot snap = await _firestore
                                .collection('store_details')
                                .document(userid)
                                .get();

                            if (snap.exists) {
                              // print('nadakkula mwone');
                              Navigator.pushNamed(context, StoreDashboard.id);
                            } else {
                              Navigator.pushNamed(context, UserDashboard.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                          // Navigator.pushNamed(context, UserDashboard.id);
                          localStorage.setString('Email', email);
                          var obtainedEmail = localStorage.getString('Email');
                          print("obtained Email:${obtainedEmail}");
                          // localStorage.setString('password', password);
                          // localStorage.setString('uid', userid);

                        }
                      } catch (e) {
                        _showAlert(context, 'You are not Registered');
                      }

                      setState(() {
                        showspinner = false;
                      });

                      // //firebase user validation
                      // Navigator.pushNamed(context, UserDashboard.id);
                    },
                    minWidth: 130,
                    child: Text(' Log In '),
                    textColor: Colors.white,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 2,
                    height: 40,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPassword.id);
                  },
                  child: Text('Forgot Password'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Saving data to sharedmemory
