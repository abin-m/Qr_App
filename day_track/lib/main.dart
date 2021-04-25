import 'package:day_track/screens/dashboard_admin.dart';
import 'package:day_track/screens/dashboard_user.dart';
import 'package:day_track/screens/login.dart';
import 'package:day_track/screens/register.dart';
import 'package:day_track/screens/dashboard_pages.dart';
import 'package:day_track/screens/store_registration.dart';
import 'package:day_track/screens/welcomscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

SharedPreferences localStorage;
String finalpass;
var initialRoot = Welcomescreen.id;
// shared preferences initialization
void initState() {
  init();
}

Future init() async {
  localStorage = await SharedPreferences.getInstance();
  var obtainedEmail = localStorage.getString('Email');
  print('Obtained passs:?$obtainedEmail');

  finalpass = obtainedEmail;
  print(finalpass);
  if (finalpass == null) {
    initialRoot = Loginpage.id;
  } else {
    initialRoot = UserDashboard.id;
  }
}

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoot,
    routes: {
      Welcomescreen.id: (context) => Welcomescreen(),
      Loginpage.id: (context) => Loginpage(),
      RegistrationPage.id: (context) => RegistrationPage(),
      Storeregistration.id: (context) => Storeregistration(),
      UserDashboard.id: (context) => UserDashboard(),
      StoreDashboard.id: (context) => StoreDashboard(),
      ForgotPassword.id: (context) => ForgotPassword(),
    },
  ));
}
