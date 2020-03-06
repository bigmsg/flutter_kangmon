import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        //length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('영자'),
          ),
          bottomNavigationBar: Material(
            //color: Colors.grey,
              child: Container(
                  decoration: BoxDecoration(
                    //color: Theme.of(context).primaryColor,
                    color: Color.fromARGB(0, 24, 24, 24),
                    border: Border(
                      top: BorderSide(
                        color: Colors.black12,
                        width: 1,
                      ),
                    ),
                  ),
                  //height: 65,
                  //color: Color.fromARGB(100, 24, 24, 24),
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 0.0),
                        insets: EdgeInsets.symmetric(horizontal:16.0)
                    ),
                    tabs: <Widget>[
                      Tab(child: Text('레슨심사')),
                      Tab(child: Text('강사목록')),
                      Tab(child: Text('통계보기')),
                    ],
                  )
              )
          ),
          body: TabBarView(
            //controller: ctr,
              children: <Widget> [
                Center(
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        child: Text('로그인 체크'),
                        onPressed: () async {
                          var res = await request.get(chkAutologinUrl);
                          print(res.content());
                        },
                      ),
                    ],
                  ),


                ),
                Center(child: Text('강사목록')),
                Center(child: Text('통계보기')),
              ]
          ),
        )
    );
  }
}


