import 'package:day_track/screens/dashboard_admin.dart';
import 'package:day_track/screens/dashboard_user.dart';
import 'package:day_track/screens/login.dart';
import 'package:day_track/screens/register.dart';

import 'package:day_track/screens/store_registration.dart';
import 'package:day_track/screens/welcomscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: StoreDashboard.id,
    routes: {
      Welcomescreen.id: (context) => Welcomescreen(),
      Loginpage.id: (context) => Loginpage(),
      RegistrationPage.id: (context) => RegistrationPage(),
      Storeregistration.id: (context) => Storeregistration(),
      UserDashboard.id: (context) => UserDashboard(),
      StoreDashboard.id: (context) => StoreDashboard(),
    },
  ));
}
