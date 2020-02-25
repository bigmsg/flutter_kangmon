import 'package:flutter/material.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioRegisterPage extends StatefulWidget {
  @override
  _PortfolioRegisterPageState createState() => _PortfolioRegisterPageState();
}

class _PortfolioRegisterPageState extends State<PortfolioRegisterPage> {

  String mb_id = '';
  @override
  void initState() {
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강사 경력및 자격증등록'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('경력및 자격증 등록'),
          Text('mb_id: $mb_id'),
          FlatButton(
            onPressed: setId,
            child: Text('mb_id 저장'),
          ),
          FlatButton(
            onPressed: getId,
            child: Text('mb_id 불러오기'),
          ),
          FlatButton(
            onPressed: ()  {
              initialId();
            },
            child: Text('mb_id 초기화'),
          ),

          FlatButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LessonRegisterPage())),
            child: Text('레슨등록'),
          ),
        ]
      ),
    );
  }

  Future setId() async {
    print('call setId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('mb_id 저장');
    pref.setString('mb_id','mania');
    print('mb_id: ' + pref.get('mb_id'));
    setState(() {
      this.mb_id = pref.get('mb_id');
    });

  }

  Future getId() async {
    print('call getId');
    SharedPreferences pref = await SharedPreferences.getInstance();

    if(pref.containsKey('mb_id')) {
      var mb_id = pref.getString('mb_id') ?? '';
      setState(() {
        this.mb_id = mb_id;
      });
    } else {
      print('not key mb_id');

      setState(() {
        this.mb_id = '';
      });

    }
    //return pref.get('mb_id');
  }

  Future initialId() async {
    print('call initialId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('mb_id', '');
    pref.remove('mb_id');
    this.mb_id = '';
    pref.clear();
    currentUserBloc.fetch();
    //print('mb_id: ' + pref.get('mb_id'));
    //this.mb_id = pref.get('mb_id');
  }
}
