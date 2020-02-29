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
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
    idController.text = 'gt';
    passwordController.text = 'dizzy8036!@';
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
              ),

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        "강사로그인",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.grey,
                      onPressed: () {
                        idController.text = 'bigmsg';
                        passwordController.text = '0000';
                        onSubmit(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        onSubmit(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

              SizedBox(
                width: MediaQuery.of(context).size.width/3,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "로그아웃",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  color: Colors.grey,
                  onPressed: () {
                    logout(context);
                  },
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(
                width: MediaQuery.of(context).size.width/3,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "로그인 체크",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    loginCheck(context);
                  },
                ),
              ),


              FlatButton(
                child: Text("아직 회원이 아니신가요? 회원가입"),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SigninPage()));
                },
              ),

            ],
          ),
        ),
      )



    );
  }
  /*void onSubmit() {
    print("submit id: ${idController.text}, pass: ${passwordController.text}");
  }*/

  onSubmit(BuildContext context) async {

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
      //'device_id': app.device.deviceId,
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
      'device_id': app.device.deviceId,
      'PHPSESSID' : jsdata['PHPSESSID'],
      'key_ck_mb_id': jsdata['key_ck_mb_id'],
      'key_ck_auto': jsdata['key_ck_auto'],
      'val_ck_mb_id': jsdata['val_ck_mb_id'],
      'val_ck_auto': jsdata['val_ck_auto'],
    };

    pref.setString('userInfo', json.encode(userInfo));
    pref.setString('cookies', json.encode(cookies));
    /*var v = pref.getString('userInfo');
    var co = pref.getString('cookies');
    var info = json.decode(v);
    var co2 = json.decode(co);
    print(info['mb_id']);
    print(co2['PHPSESSID']);*/





    /*await Requests.setStoredCookies(hostname, {
      'PHPSESSID': jsdata['PHPSESSID'],
      jsdata['key_ck_mb_id']: jsdata['val_ck_mb_id'],
      jsdata['key_ck_auto']: jsdata['val_ck_auto'],
    });*/


    var cookies2 = await Requests.getStoredCookies(hostname);
    print('------ new cookies ------');
    print(cookies2);



  }

  void loginCheck(BuildContext context) async {
    print('-------- 로그인 체크 -------------');
    var user = Provider.of<CurrentUser>(context, listen: false);
    var params = {
      'mb_id': user.data.mb_id,
      'mb_password': user.data.mb_password
    };
    String hostname = Requests.getHostname(loginUrl);
    //var res = await Requests.post(appUrl + '/chk_login.php', body: params);
    var res = await request.post(appUrl + '/chk_login.php', body: params);
    await request.setCookies();
    var cookies = await Requests.getStoredCookies(hostname);
    print(cookies);
    print('----- my request result ----------');
    print(res.content());


  }
}
