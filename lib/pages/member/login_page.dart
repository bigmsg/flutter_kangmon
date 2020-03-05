import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/main.dart';
import 'package:flutter_kangmon/models/app_state_provider.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/member/signin_page.dart';
import 'package:flutter_kangmon/widgets/alert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'package:requests/requests.dart';

import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  bool isPreviousTabView;

  LoginPage({this.isPreviousTabView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  @override
  initState() {
    super.initState();
    idController.text = 'bigmsg';
    passwordController.text = '0000';
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:
      GestureDetector(
        // keyboard down
        onTap: () {
          print("onTapped");
          FocusScope.of(context).unfocus();
        },
        child: Container(
          // status bar heigt: MediaQuery.of(context).padding.top
          padding: EdgeInsets.fromLTRB(10, MediaQuery.of(context).padding.top,10,10),
          decoration: BoxDecoration(
            //color: Colors.lightBlue,
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                //stops: [0.1, 0.5, 0.7, 0.9],
                colors: [ Colors.red, Colors.blue]
            ),
          ),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.isPreviousTabView == null ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                )
              : SizedBox(height: 0),

              // Logo
              Image(
                height: 100,
                image: AssetImage('assets/images/logo.png'),
              ),
              SizedBox(height: 10,),
              // ID
              TextField(
                controller: idController,

                obscureText: false,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "ID"
                ),
              ),
              SizedBox(height: 8),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                ),
              ),
              SizedBox(height: 20),
              // 로그인
              SizedBox(
                width: MediaQuery.of(context).size.width/3,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  color: Colors.yellow,
                  onPressed: () {
                    _onSubmit(context);
                  },
                ),
              ),
              SizedBox(height: 20,),





              FlatButton(
                child: Text("아직 회원이 아니신가요? 회원가입"),
                onPressed: () {
                  if(widget.isPreviousTabView == null)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SigninPage()));
                  else
                    Navigator.push(context, MaterialPageRoute(builder: (_) => SigninPage()));
                },
              ),

            ],
          ),
        ),
      )



    );
  }


  _onSubmit(BuildContext context) async {

    print("submit id: ${idController.text}, pass: ${passwordController.text}");
    var user = Provider.of<CurrentUser>(context, listen: false);
    var app = Provider.of<AppStateProvider>(context, listen: false);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var a = pref.containsKey('cookies');
    if(pref.containsKey('cookies')) {
      print('true');
    } else
      print('false');

    print('containsKey cookies: $a');
    //return;
    String hostname = Requests.getHostname(loginUrl);
    var cookies1 = await Requests.getStoredCookies(hostname);
    print('------ old cookies ------');
    print(cookies1);
    print(cookies1['PHPSESSID']);

    var params = {
      'device_id': app.device.deviceId,
      'mb_id': idController.text,
      'mb_password': passwordController.text,
      //'session_key': user.data.session_key,
      //'session_id': user.data.session_id,
    };

    print('params: ' + params.toString());
    /*var res = await Requests.post(
      loginUrl,
      body: params,
    );*/


    var res = await request.post(
      loginUrl,
      body: params,
    );

    if (res.statusCode != 200) {
      showAlertDialog(context,'로그인 에러', '로그인시도중 에러가 발생하였습니다.');
      return;
    }

    print('------ Requests result -----');
    print(res.statusCode);
    print(res.content());

    dynamic jsdata = res.json();


    var userInfo = {
      'mb_id': jsdata['mb_id'],
      'mb_password': jsdata['mb_password'],
      'mb_group': jsdata['mb_group'],
      'mb_nick': jsdata['mb_nick'],
      'mb_hp': jsdata['mb_hp'],
      'mb_photo': jsdata['mb_photo']
    };

    var cookies = {
      'PHPSESSID' : jsdata['PHPSESSID'],

      'key_device_id': jsdata['key_device_id'],
      'val_device_id': jsdata['val_device_id'],

      'key_ck_mb_id': jsdata['key_ck_mb_id'],
      'val_ck_mb_id': jsdata['val_ck_mb_id'],

      'key_ck_auto': jsdata['key_ck_auto'],
      'val_ck_auto': jsdata['val_ck_auto'],
    };

    pref.setString('userInfo', json.encode(userInfo));
    pref.setString('cookies', json.encode(cookies));

    //myLessonsBloc.fetch();
    //myLessonsBloc.remove();

    await Provider.of<CurrentUser>(context, listen: false).fetch();
    if(widget.isPreviousTabView == null)
      Navigator.pop(context);
    //else
      //Navigator.pushReplacementNamed(context, '/');



  }

  void loginCheck(BuildContext context) async {
    print('-------- 로그인 체크 -------------');
    var user = Provider.of<CurrentUser>(context, listen: false);
    var params = {
      'mb_id': user.data.mb_id,
      'mb_password': user.data.mb_password
    };
    String hostname = Requests.getHostname(loginUrl);
    var cookies = await Requests.getStoredCookies(hostname);
    print(cookies);


    //var res = await Requests.post(appUrl + '/chk_login.php', body: params);
    var res = await request.post(appUrl + '/chk_login.php', body: params);
    //await request.setCookies();
    print('----- my request result ----------');
    print(res.content());
    myLessonsBloc.fetch();
    lessonsBloc.fetch();

  }
}
