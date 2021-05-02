import 'package:day_track/screens/dashboard_user.dart';
import 'package:day_track/screens/login.dart';
import 'package:day_track/screens/register.dart';
import 'package:day_track/screens/store_registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard_admin.dart';

String storedUid;

class Welcomescreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  SharedPreferences localStorage;
  String finalpass;
  var initialRoot = Welcomescreen.id;

// shared preferences initialization

  Future init() async {
    localStorage = await SharedPreferences.getInstance();
    // var obtainedEmail = localStorage.getString('Email');
    var obtainedUid = localStorage.getString('uid');
    print('Obtained passs:?$obtainedUid');
    setState(() {
      storedUid = obtainedUid;
    });
    finalpass = obtainedUid;

    print(finalpass);
    if (finalpass == null) {
      Navigator.pushNamed(context, Loginpage.id);
      // initialRoot = Loginpage.id;
    } else {
      // initialRoot = UserDashboard.id;
      try {
        DocumentSnapshot snap = await _firestore
            .collection('store_details')
            .document(obtainedUid)
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
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 180,
            ),
            Image(
              image: AssetImage('images/Beach.png'),
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, Loginpage.id);
                },
                minWidth: 200,
                child: Text(
                  ' Log In',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                textColor: Colors.white,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 2,
                height: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: new MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                minWidth: 200,
                child: Text(
                  ' Register Now ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                textColor: Colors.white,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 2,
                height: 50,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Storeregistration.id);
                },
                child: Text('Register Your Store'))
          ],
        ),
      ),
    );
  }
}
