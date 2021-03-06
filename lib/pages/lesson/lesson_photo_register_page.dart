import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson_photos_provider.dart';
import 'package:flutter_kangmon/models/providers.dart';
import 'package:flutter_kangmon/models/registering_lesson_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LessonPhotoRegisterPage extends StatefulWidget {

  @override
  _LessonPhotoRegisterPageState createState() => _LessonPhotoRegisterPageState();
}

class _LessonPhotoRegisterPageState extends State<LessonPhotoRegisterPage> {


  @override
  Widget build(BuildContext context) {

    final photos = Provider.of<LessonPhotos>(context);
    print("------------ photos list ----------");
    print(photos.image);
    print('wr_id: ${photos.wr_id}');


    return Scaffold(
      body: GridView.count(
          padding: EdgeInsets.all(10.0),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: List.generate(photos.image.length, (index) {
            return _buildPhoto(photos, index);
          }),
        ),
      );
  }

  // 이미지 배치하기
  _buildPhoto(dynamic photos, int index) {

    if (photos.image[index] == null || photos.image[index] == 0 || photos.image[index] == '') { //0: 업로드중
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container( // 테두리
              height: 120.0,
              width: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
            ),
            Positioned( // 사진 아이콘
              bottom: 45.0,
              child: Column(
                children: <Widget>[
                  photos.image[index] == null ? Icon(
                    Icons.photo,
                    size: 30,
                    color: Colors.grey,
                  ) : CircularProgressIndicator()
                  ,
                ],
              ),
            ),
            Positioned( // 버튼
              bottom: 10, right: 10,
              child: Container(
                //width: 30.0, height: 30.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).buttonColor,
                  //color: Color.fromRGBO(12, 12, 12, 0.8),
                  //color: The,
                  //color: Colors.grey,
                  //color: Colors.green,
                  borderRadius: BorderRadius.circular(30.0),

                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    _pickImage(photos, index);
                  },
                ),
              ),
            ),
          ],
        ),
      );


    } else {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            Container( // 이미
              height: 120.0, width: 180.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(photos.image[index]),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
            ),

            Container( // 이미지 테두리
              height: 121.0,
              width: 181.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5, color: Colors.grey),
              ),
            ),

            Positioned( // 버튼
              bottom: 10, right: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    _removeImage(photos, index);
                  },
                ),

              ),
            ),
          ],
        ),
      );
    }
  }


  // 이미지 선택
  _pickImage(dynamic photos, int index) async {
    print('call _pickImage()');
    print('index: ${index}');
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);

    final photos = Provider.of<LessonPhotos>(context, listen: false);

    var params = {
      'table': 'mico_lesson',// jquery-file-upload에서는  table로 쥐야 함, 아니면 이상하게 에러발생함
      'mb_id': 'bigmsg',
      //'wr_id': photos.wr_id.toString(),
      'wr_id': '2',
      'bf_no': index.toString(),
    };

    // 서버에 즉시 저장하기
    print('start upload');
    print('upload url: ${photoRegisterUrl}?wr_id=${photos.wr_id}');
    if(file == null) return;
    else {
      photos.upload(file, index, params).then((result) {
        if(result['result']) {
          lessonsBloc.fetch();
        }

        print('-------- rst upload --------');
        print(result);
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('${result['message']}'),
            duration: Duration(milliseconds: result['result'] ? 500 : 4000),));

      });

    }



  }



  // 이미지 삭제
  _removeImage(dynamic photos, int index) {
    //1. 서버삭제

    print('removeImage ');
    //2. provider 삭제
    photos.remove(index).then((result) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('${result['message']}'),
          duration: Duration(milliseconds: result['result'] ? 500 : 4000),));
    });
  }

}



class Photo {

}