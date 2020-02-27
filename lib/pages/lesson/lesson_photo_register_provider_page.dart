import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

/*
  폐기된 파일
  20.02.27

  provider 사용한 상태관리 예제
  - rxdart bloc 패턴이 심플한 것 같아서
  - rxdart bloc 패턴으로 소스 변경함
  - lesson_photo_register_page.dart


 */


class LessonPhotoRegisterPage2 extends StatefulWidget {
  @override
  _LessonPhotoRegisterPageState2 createState() => _LessonPhotoRegisterPageState2();
}

class _LessonPhotoRegisterPageState2 extends State<LessonPhotoRegisterPage2> {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LessonPhotos()),
      ],
      child: Consumer<LessonPhotos>(builder: (context, photos, _){

        final photos = Provider.of<LessonPhotos>(context);

        return Scaffold(
          appBar: AppBar(
              title: Text('레슨 사진등록(업데이트)')
          ),
          body: GridView.count(
            padding: EdgeInsets.all(10.0),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            //maxCrossAxisExtent: 150,
            //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
            children: List.generate(photos.image.length, (index) {
              return _buildPhoto(photos, index);
            }),
          ),
          /*body: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150, mainAxisSpacing: 4, crossAxisSpacing: 4),
            itemBuilder: null
          ),*/
        );
      },),
    );
  }


  _buildPhoto(dynamic photos, int index) {

    if (photos.image[index] == null || photos.image[index] == 0) {
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
                  photos.image[index] == null ? Icon(
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
              Container(
                height: 120.0, width: 180.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(photos.image[index]),
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



  Future _pickImage(dynamic photos, int index) async {
    print('call getImage()');
    var file = await ImagePicker.pickImage(source: ImageSource.gallery);
    //var file = await ImagePicker.pickVideo(source: ImageSource.gallery); // video 선택하기

    // 서버에 즉시 저장하기
    print('start upload');
    if(file == null) return;
    else {
      var result = _uploadImage(file, photos, index);

      print('end upload: $result');
      //
      //setState(() => _image[index] = image);
    }
  }

  _uploadImage(File file, dynamic photos, int index) async {
    print('upload... $index');

    photos.change(index, 0);

    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    var res = await http.post(photoRegisterUrl, body: {
      "image": base64Image,
      "name": fileName,
    });
    /*.then((res) {
      print(res.statusCode);
      print(res.body);
    }).catchError((err) {
      print(err);
    });*/
    print('body: ' + res.body);
    //var js = json.decode(res.body);
    //photos.image[index] = res.body;
    photos.change(index, res.body);
    print(photos.image[index]);

    /*http.post(photoRegisterUrl, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
      print(res.body);
    }).catchError((err) {
      print(err);
    });*/

    /*
      실패: 나중에 동영상 업로드시 다시 에러 수정해야 함
      이유: flutter에서 데이터 전송은 OK
        - php에서 어떻게 데이터를 받아야하는지 모르겠음
    */

    /*

    var request = http.MultipartRequest("POST", Uri.parse(photoRegisterUrl));
    var multipartFile = http.MultipartFile.fromBytes('image', image.readAsBytesSync(),
      contentType: MediaType('image','jpg'),);

    //request.headers = { "Content-Type":"multipart/form-data" };
    request.fields['file_name'] = fileName;
    request.fields['mb_id'] = currentUser.mb_id;
    request.files.add(multipartFile);
    //http.StreamedResponse response =  await request.send();
    var streamResponse =  await request.send();
    var response = await http.Response.fromStream(streamResponse);
    print(response.body);
    */

  }

  _removeImage(dynamic photos, int index) {
    photos.remove(index);
    //setState(() => _image[index] = null);
  }
}