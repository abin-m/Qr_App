import 'package:day_track/screens/scanhistory.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  static const String id = 'UserDashboard';
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
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
            case 1:
              Navigator.pushNamed(context, ScanHistory.id);
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(29.0),
              child: Image(
                image: AssetImage('images/qr.png'),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: new MaterialButton(
                onPressed: () {
                  // Navigator.pushNamed(context, RegistrationPage.id);
                },
                minWidth: 130,
                child: Text(
                  ' Scan QR ',
                  style: TextStyle(fontSize: 17),
                ),
                textColor: Colors.white,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 2,
                height: 55,
              ),
            )
          ],
        ),
      ),
    );
  }
}
