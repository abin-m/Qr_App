import 'package:flutter/material.dart';

class StoreDashboard extends StatefulWidget {
  static const String id = 'StoreDashboard';
  @override
  _StoreDashboardState createState() => _StoreDashboardState();
}

class _StoreDashboardState extends State<StoreDashboard> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
