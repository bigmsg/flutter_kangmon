import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'dart:convert';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<String> getData() async {
    /*Future<String> response = await http.get(
      Uri.encodeFull('https://'),
      headers: {'Accept': 'application/json'}
    );*/
    //var response = await http.get('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {});
    /*var response = await http.post('https://www.massagemania.co.kr/_mobileapp/admin/test.php', body: {'mb_id': 'mania'});
    print(response.body);


     */
    var response = await http.post('https://www.massagemania.co.kr/_mobileapp/admin/test.php',
        body: {'mb_id': 'mania'}).then(
        (http.Response response) {
          final int statusCode = response.statusCode;
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          print(response.body);
          //return json.decode(response.body);
        });
    print(response);
    return '00';
  }

  /*Future getData() async {

  }*/

  @override
  initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강몬'),
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30.0,
          onPressed: () {},
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: getData,
          ),
        ],
      ),
      body: ListView(
          children: <Widget>[
              Text('Content'),
            ]
      ),
    );
  }
}
