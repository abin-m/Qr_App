import 'package:day_track/screens/login.dart';
import 'package:day_track/screens/register.dart';
import 'package:day_track/screens/store_registration.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatefulWidget {
  static const String id = 'Welcome_Screen';
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: new MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Loginpage.id);
                    },
                    minWidth: 130,
                    child: Text(' Log In'),
                    textColor: Colors.white,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 2,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: new MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationPage.id);
                    },
                    minWidth: 130,
                    child: Text(' Register Now '),
                    textColor: Colors.white,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 2,
                    height: 40,
                  ),
                )
              ],
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
