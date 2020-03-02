import 'package:flutter/material.dart';
import 'package:flutter_kangmon/help/common.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:provider/provider.dart';


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {



  @override
  Widget build(BuildContext context) {

    var currentUser = Provider.of<CurrentUser>(context);

    var menus = ['정보수정', '로그아웃'];
    if (currentUser.data.mb_group == '') {
      menus.add('강사등록');
    }

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
            if(menus[index] == '로그아웃') {
              return Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    logout(context);
                  },
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
                ),
              );
            } else {
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
            }
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
