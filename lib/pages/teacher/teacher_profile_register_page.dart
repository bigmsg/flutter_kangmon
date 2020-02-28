import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_photo_register_page.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_content_register_page.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


class TeacherProfileRegisterPage extends StatefulWidget {
  @override
  _TeacherProfileRegisterPageState createState() => _TeacherProfileRegisterPageState();
}

class _TeacherProfileRegisterPageState extends State<TeacherProfileRegisterPage> {

  File _image;
  TextEditingController _profileController = TextEditingController();
  TextEditingController _hpController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //_hpController.text = currentUser.mb_hp;


    final currentUser = Provider.of<CurrentUser>(context);
    _hpController.text = currentUser.data.mb_hp;

    var mb = Provider.of<CurrentUser>(context);
    print('teacher profile mb_nick: ' + mb.data.mb_nick);
    print(WidgetsBinding.instance.window.platformBrightness);
    print('${MediaQuery.of(context).platformBrightness}');

    return Scaffold(
      appBar: AppBar(
        title: Text('강사등록'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('provider(mb_id):' + mb.data.mb_id),
              Text('강사등록비는 2020년까지 무료입니다.\n금액은 차후에 결정됩니다.'),
              SizedBox(height: 20,),
              TextField(
                controller: _profileController,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                //obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "경력 및 자격증"
                ),
              ),
              SizedBox(height: 10,),

              TextField(
                controller: _hpController,
                style: TextStyle(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "휴대폰"
                ),
              ),
              SizedBox(height: 20,),

              _image == null ? Text('No image selected') : Image(
                height: 300,
                width: MediaQuery.of(context).size.width,
                image: FileImage(_image),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20,),

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
                    print('profile brightness');
                    print('${MediaQuery.of(context).platformBrightness}');
                    //_onSubmit(context);
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text('레슨등록'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LessonContentRegisterPage()));
                    },
                  ),

                  FlatButton(
                    child: Text('사진등록'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => LessonPhotoRegisterPage()));
                    },
                  ),
                ],
              ),

              /*FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Pick Image',
                child: Icon(Icons.add_a_photo),
              ),*/
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future setId() async {
    print('call setId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('mb_id 저장');
    pref.setString('mb_id','mania');
    print('mb_id: ' + pref.get('mb_id'));

  }

  Future getImage() async {
    print('call getImage()');
    //var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    /*setState(() {
      _image = image;
    });*/
    setState(() => _image = image);
  }

}
