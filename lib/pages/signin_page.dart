import 'package:flutter/material.dart';


class SigninPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 '),

      ),
      body: Column(
        children: <Widget>[
          Text('회원가입하기 '),
        ],
      )
    );
  }
}
