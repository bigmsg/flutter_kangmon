import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/signin_page.dart';
import 'package:flutter_kangmon/widgets/alert_widget.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'dart:convert';


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
      body: /*Column(
        children: <Widget>[
          Text('아이디, 비번'),
          FlatButton(
            child: Text(
              '회원가입',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SigninPage())),
          ),
        ],
      ),*/
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
          child: Column(
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
              SizedBox(
                width: double.infinity,
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

              FlatButton(
                child: Text("아직 회원이 아니신가요? 회원가입"),
                onPressed: () {
                  Navigator.pop(context);
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

  Future<String> onSubmit(BuildContext context) async {
    /*Future<String> response = await http.get(
      Uri.encodeFull('https://'),
      headers: {'Accept': 'application/json'}
    );*/
    //var response = await http.get('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {});
    /*var response = await http.post('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {'mb_id': 'mania'});
    print(response.body);


     */

    print("submit id: ${idController.text}, pass: ${passwordController.text}");
    var response = await http.post(loginUrl,
        body: {'mb_id': idController.text, 'mb_password': passwordController.text}).then(
            (http.Response response) {
          final int statusCode = response.statusCode;
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          var js = json.decode(response.body);
          print(response.body);
          if (js['success']) {
            print('mb_id: ' + js['mb_id']);
            print('mb_nick: ' + js['mb_nick']);
            print('mb_hp: ' + js['mb_hp']);
            currentUser = User(mb_nick: js['mb_nick'], mb_id: js['mb_id'], mb_hp: js['mb_hp']);
            print(currentUser.mb_nick);

            Navigator.pop(context);
          } else {
            //print(js['message']);
            showAlertDialog(context,'로그인 에러', js['message']);
          }


          // currentUser data 저장

          // 화면이동
          //Navigator.pop(context);
          //return json.decode(response.body);
        });
    //print(response);
    return '00';
  }
}
