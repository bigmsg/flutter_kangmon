import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class LessonPhotoRegisterBlocPage extends StatefulWidget {
  @override
  _LessonPhotoRegisterBlocPageState createState() => _LessonPhotoRegisterBlocPageState();
}

class _LessonPhotoRegisterBlocPageState extends State<LessonPhotoRegisterBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('레슨 사진등록(Bloc)')
      ),
      body: StreamBuilder(
        stream: lessonPhotosBloc.photos,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GridView.count(
              padding: EdgeInsets.all(10.0),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: List.generate(snapshot.data.length, (index) {
                return _buildPhoto(snapshot.data, index);
              }),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  // 이미지 배치하기
  _buildPhoto(List<dynamic> images, int index) {

    if (images[index] == null || images[index] == 0) {
      return Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 120.0,
              width: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5),
              ),
            ),
            Positioned(
              bottom: 45.0,
              child: Column(
                children: <Widget>[
                  images[index] == null ? Icon(
                    Icons.photo,
                    size: 30,
                    color: Colors.grey,
                  ) : CircularProgressIndicator()
                  ,
                ],
              ),
            ),
            Positioned(
              bottom: 10, right: 10,
              child: Container(
                //width: 30.0, height: 30.0,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    _pickImage(index);
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
            Container(
              height: 120.0, width: 180.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(10.0)
              ),
            ),

            Positioned(
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
                    _removeImage(index);
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
  _pickImage(int index) async {
    print('call getImage()');
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var file = await ImagePicker.pickVideo(source: ImageSource.gallery); // video 선택하기

    // 서버에 즉시 저장하기
    print('start upload');
    if(file == null) return;
    else {
      _uploadImage(file, index);
    }
  }

  // 이미지 서버업로드
  _uploadImage(File file, int index) async {
    //print('upload... $index');

    lessonPhotosBloc.change(index, 0);

    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    var res = await http.post(photoRegisterUrl, body: {
      "image": base64Image,
      "name": fileName,
    });

    //print('body: ' + res.body);
    //var js = json.decode(res.body);
    //photos.image[index] = res.body;
    lessonPhotosBloc.change(index, res.body);
    //print(.image[index]);


  }

  // 이미지 삭제
  _removeImage(int index) {
    lessonPhotosBloc.remove(index);
  }

}
