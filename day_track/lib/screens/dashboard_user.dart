import 'package:barcode_scan/barcode_scan.dart';
import 'package:day_track/screens/dashboard_pages.dart';

import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  static const String id = 'UserDashboard';
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<BottomNavigationBarItem> _items;
  String value = "";
  // int index = 0;
  String qrCodeResult = "";
  int selectedIndex = 0;
  @override
  void initState() {
    _items = new List();
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.qr_code_scanner), title: new Text('Scan QR')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.history), title: new Text('History')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.logout), title: new Text('Log Out')));
  }

  var _pages = [ScanQr(), History(), LogOut()];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        items: _items,
        fixedColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: _pages[selectedIndex],
    );
  }
}
