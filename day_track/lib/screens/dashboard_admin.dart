import 'package:day_track/screens/dashboard_pages.dart';
import 'package:day_track/screens/dashboard_user.dart';
import 'package:flutter/material.dart';

class StoreDashboard extends StatefulWidget {
  static const String id = 'StoreDashboard';
  @override
  _StoreDashboardState createState() => _StoreDashboardState();
}

class _StoreDashboardState extends State<StoreDashboard> {
  List<BottomNavigationBarItem> _items;
  String value = "";
  int index = 0;
  @override
  void initState() {
    ShowQRCode();
    _items = new List();

    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.person_search), title: new Text('Visitors')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.date_range), title: new Text('Search by date')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.qr_code), title: new Text('Your QR')));
    _items.add(new BottomNavigationBarItem(
        icon: new Icon(Icons.logout), title: new Text('Logout')));
  }

  var _pages = [VistorsDetails(), SearchByDate(), ShowQRCode(), StoreLogOut()];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: new BottomNavigationBar(
        unselectedItemColor: Colors.black54,
        items: _items,
        fixedColor: Colors.black,
        currentIndex: index,
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
      ),
      body: SafeArea(child: _pages[index]),
    );
  }
}
