import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kangmon/models/app_state_provider.dart';
import 'package:flutter_kangmon/models/comment_bloc.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/registering_lesson_provider.dart';
import 'package:flutter_kangmon/pages/admin/admin_home.dart';
import 'package:flutter_kangmon/pages/home_page.dart';
import 'package:flutter_kangmon/pages/teacher/teacher_home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_kangmon/help/common.dart';

import 'data/style.dart';
import 'models/lesson_photos_provider.dart';
import 'models/providers.dart';


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
        ChangeNotifierProvider.value(value: AppStateProvider(),),
        ChangeNotifierProvider.value(value: RegisteringLessonProvider(),),
        //ChangeNotifierProvider.value(value: BoardProvider(),),
        //ChangeNotifierProvider.value(value: CommentProvider(),),
        //ChangeNotifierProvider<CommentProvider>(create: (_) => CommentProvider(),),
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

    var app = Provider.of<AppStateProvider>(context, listen: false);
    /*print('id: ' + app.device.deviceId);
    print('version: ' + app.device.version);
    print('platform: ' +app.device.platform);
    print('machine: ' + app.device.machine);

     */

    return MaterialApp(
      title: '강사몬',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      /*routes: <String, WidgetBuilder> {
        '/AdminHome': (BuildContext context) => AdminHome(),
        '/TeacherHome' : (BuildContext context) => TeacherHome(),
      },*/
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/AdminHome': (context) => AdminHome(),
        '/TeacherHome': (context) => TeacherHome(),
      },

      //home: HomePage(),

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
