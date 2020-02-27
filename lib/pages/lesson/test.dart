import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:provider/provider.dart';



class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {



  @override
  Widget build(BuildContext context) {

    Provider.of<TestUser>(context, listen: false).change(User(
        mb_id: 'bigmsg',
        mb_nick: '게스트',
        mb_password: '0070',
        mb_hp: '010-0000-1111',
        mb_photo: '',
        mb_group: 'client'
    ));

    var mb = Provider.of<TestUser>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Provider 값 변경해보기'),

      ),
      body: Center(
        child: Text(mb.data.mb_nick, style: TextStyle(
          fontSize: 40,
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<TestUser>(context, listen: false).change(User(
              mb_id: 'bigmsg',
              mb_nick: '안녕하세요',
              mb_password: '0070',
              mb_hp: '010-0000-1111',
              mb_photo: '',
              mb_group: 'client'
          ));
        },
      ),
    );
  }
}
