import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _localController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입 '),

      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _subjectController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "이메일(id)"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: _localController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "비밀번호"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "닉네임"
                      ),
                      onChanged: (text) {
                        print(text);
                        //_priceController.text = 'W' + text;
                      }
                  ),
                  SizedBox(height: 10,),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      child: Text(
                        "저장하기",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      color: Colors.yellow,
                      onPressed: () {
                        _onSubmit(context);
                      },
                    ),
                  ),


                ]
            ),
          ),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) {

  }

}
