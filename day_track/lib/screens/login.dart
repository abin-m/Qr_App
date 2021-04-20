import 'package:day_track/screens/dashboard_user.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  static const String id = 'Login_page';
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String email;
  String password;
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
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: new MaterialButton(
                  onPressed: () {
                    //firebase user validation
                    Navigator.pushNamed(context, UserDashboard.id);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
