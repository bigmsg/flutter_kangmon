import 'package:flutter/material.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kangmon/help/common.dart';

import 'models/providers.dart';

//final lessonPhotos = LessonPhotos();

//void main() => runApp(MyApp());
void main() {
  //SharedPreferences.setMockInitialValues({}); // 꼭 해줘야 SharedPreferences 사용가능함
  //prefs.setMockInitialValues(values) // values type is Map<String, dynamic>
  /*return runApp(MultiProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => LessonPhotos()),
        ChangeNotifierProvider.value(value: LessonPhotos(),),
        ChangeNotifierProvider.value(value: TestUser(),),
      ],
      child: Consumer<TestUser>(builder: (context, users, _){
        return MyApp();
      })
      //child: MyApp(),
    )
  );*/

  return runApp(MyApp());
}





class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('------ 앱시작 ---------');
    //var a = Provider.of<LessonPhotos>(context); // 단발성 사용시 listen: false

    return MultiProvider(

        // providers: 상태관리하고자하는 모든 객체 씀
        providers: [
          //ChangeNotifierProvider(create: (_) => LessonPhotos()),
          ChangeNotifierProvider.value(value: CurrentUser(),),
          ChangeNotifierProvider.value(value: LessonPhotos(),),
          //ChangeNotifierProvider.value(value: TestUser(),),
        ],

        // 계층적으로 이하 widget은 모두 적용됨
        child: _buildMaterialApp(),
        /*
        // 아래와 같이 Consumer를 쓸 수 있으나 위에 소스는 생략했음, 가능하네??? ㅎㅎ

        child: Consumer<LessonPhotos>(builder: (context, photos, _) {
          var a = Provider.of<LessonPhotos>(context);
          print(a.image);

          var user = Provider.of<CurrentUser>(context);
          print('initial mb_id: ' + user.data.mb_id);

          child: MaterialApp(
              title: '강사몬',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[50],
                primaryColor: Color.fromRGBO(245, 171, 161, 1), // 진한 살색
              ),
              home: HomePage(),
            );
        });
         */
    );


  }

  _buildMaterialApp() {
    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        primaryColor: Color.fromRGBO(245, 171, 161, 1), // 진한 살색
        /*textTheme: TextTheme(
                button: TextStyle(
                  color: Colors.pink,
                  fontSize: 2,
                ),
              ),*/

        //buttonColor: Colors.blue,
        //primaryColor: Colors.deepOrangeAccent,
        //primaryColor: Colors.deepOrangeAccent,
        //primaryColor: Color.fromRGBO(207, 227, 255, 1), // 하늘색
        //primaryColor: Color.fromRGBO(237, 56, 145, 1), // 핑크
        //primaryColor: Color.fromRGBO(24, 248, 222, 1), // 밝은 녹색
        //primaryColor: Color.fromRGBO(255, 230, 200, 1), // 밝은 살색
        //primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
    //}),
  }

}
