import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영자방'),
      ),
      body: Center(
        child: Text('영자방 공사중...', style: TextStyle(
          fontSize: 40
        ),),
      ),
    );
  }
}


