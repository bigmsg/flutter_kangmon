import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_kangmon/pages/lesson/lesson_register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'package:image_picker/image_picker.dart';

class TeacherRegisterPage extends StatefulWidget {
  @override
  _TeacherRegisterPageState createState() => _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends State<TeacherRegisterPage> {

  File _image;
  TextEditingController _careerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('강사등록'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('강사등록비는 2020년까지 무료입니다.\n금액은 차후에 결정됩니다.'),
              SizedBox(height: 20,),
              TextField(
                controller: _careerController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                //obscureText: false,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "경력 및 자격증"
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
                    //_onSubmit(context);
                  },
                ),
              ),
              FlatButton(
                child: Text('레슨등록하기'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LessonRegisterPage()));
                },
              ),
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

    setState(() {
      _image = image;
    });
    //setState(() => _image = image);
  }

}
