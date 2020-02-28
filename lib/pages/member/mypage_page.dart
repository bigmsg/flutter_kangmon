import 'package:flutter/material.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  var menus = ['로그인/회원가입', '정보수정', '강사등록', '레슨관리'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //centerTitle: true,
        title: Text('미용코칭몬', style: TextStyle(
            fontSize: 13.0
        ),),

      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: menus.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(menus[index]),
                  Icon(Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white70,
                  ),
                ],
              ),
            );
            },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 0.5,
              color: Colors.grey,
            );
          },
        ),

      ),
    );
  }
}
