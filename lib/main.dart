import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kangmon/help/common.dart';

import 'data/style.dart';
import 'models/lesson_photos_provider.dart';
import 'models/providers.dart';

//final lessonPhotos = LessonPhotos();

//void main() => runApp(MyApp());
void main() async {
  //SharedPreferences.setMockInitialValues({}); // 꼭 해줘야 SharedPreferences 사용가능함
  //prefs.setMockInitialValues(values) // values type is Map<String, dynamic>

  WidgetsFlutterBinding.ensureInitialized();// 뭔지 모르겠는데 이거 넣어야 Provider관련 경고창 사라짐

  // portait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    //DeviceOrientation.landscapeLeft,
    //DeviceOrientation.landscapeRight,
  ]);

  return runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LessonPhotos(),),
        ChangeNotifierProvider.value(value: CurrentUser(),),
        //ChangeNotifierProvider(create: (_) => LessonPhotos()),
        //ChangeNotifierProvider.value(value: TestUser(),),
      ],
      child: MyApp(),
    ),

  );

  //return runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('------ 앱시작 ---------');

    print('Brightness');
    print(WidgetsBinding.instance.window.platformBrightness); // should print Brightness.light / Brightness.dark when you switch



    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      /*theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        //primaryColor: Color.fromRGBO(245, 171, 161, 1), // 진한 살색
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 10,
          ),
          title: TextStyle(
              fontSize: 10
          ),
          subtitle: TextStyle(
              fontSize: 10
          ),
          caption: TextStyle(
            fontSize: 10,
          ),
          button: TextStyle(
            color: Colors.pink,
            fontSize: 12,
          ),

          body1: TextStyle( // 목록, 대부분의 글짜 크기
              fontSize: 12
          ),

          body2: TextStyle(
              fontSize: 30
          ),
          display1: TextStyle(
            fontSize: 10,
          ),
          display2: TextStyle(
            fontSize: 10,
          ),
          display3: TextStyle(
            fontSize: 20,
          ),
          display4: TextStyle(
            fontSize: 20,
          ),

          subhead: TextStyle( // TextField
            fontSize: 14,
          ),

          overline: TextStyle(
            fontSize: 10,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pink,
          height: 120.0,
          //textTheme: ButtonTextTheme.primary,

        ),
        textSelectionColor: Colors.pink,
        primaryColor: Colors.teal,
        //primaryColorBrightness: Brightness.dark, // 기본 글자색이 검정색이 됨

        //primaryColor: Colors.deepOrangeAccent,
        //primaryColor: Color.fromRGBO(207, 227, 255, 1), // 하늘색
        //primaryColor: Color.fromRGBO(237, 56, 145, 1), // 핑크
        //primaryColor: Color.fromRGBO(24, 248, 222, 1), // 밝은 녹색
        //primaryColor: Color.fromRGBO(255, 230, 200, 1), // 밝은 살색
        //primarySwatch: Colors.blue,
      ),*/

      home: HomePage(),
    );


  }


}


final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      accentColor: Colors.pink,
      primaryColor: Colors.pink,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: Colors.blue,
        textTheme: ButtonTextTheme.normal,
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white12,
      textSelectionColor: Colors.pink,
      errorColor: Colors.pinkAccent,
      textTheme: _buildShrineTextTheme(base.textTheme),
      primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
          color: Colors.pink
      ), // TODO: Decorate the inputs (103)
  );
}


TextTheme _buildShrineTextTheme(TextTheme base) {
  return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(
          fontSize: 12.0
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
      ),
    ).apply(
      //fontFamily: 'Rubik',
      displayColor: Colors.teal,
      bodyColor: Colors.white,
  );
}
