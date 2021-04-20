import 'package:day_track/screens/dashboard_user.dart';
import 'package:flutter/material.dart';

class ScanHistory extends StatefulWidget {
  static const String id = 'ScanHistory';
  @override
  _ScanHistoryState createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<BottomNavigationBarItem> _items;
  String value = "";
  int index = 0;
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        items: _items,
        fixedColor: Colors.black,
        currentIndex: index,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, UserDashboard.id);
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Text('scanf')],
        ),
      ),
    );
  }
}
