import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';
import 'package:flutter_kangmon/models/my_lessons_bloc.dart';
import 'package:flutter_kangmon/models/registering_lesson_provider.dart';
import 'package:provider/provider.dart';


class LessonContentRegisterPage extends StatelessWidget {

  TextEditingController _subjectController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _localController = TextEditingController();
  TextEditingController _priceController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    var currentLesson = Provider.of<RegisteringLessonProvider>(context, listen: false);
    if(currentLesson.data != null) {
      print('local: ${currentLesson.data.wr_local}');
      print('price: ${currentLesson.data.wr_price}');
      print(currentLesson.data.wr_price);
      _subjectController.text = currentLesson.data.wr_subject;
      _contentController.text = currentLesson.data.wr_content;
      _localController.text = currentLesson.data.wr_local;
      _priceController.text = currentLesson.data.wr_price == 0 ? '': currentLesson.data.wr_price.toString();
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _subjectController,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "제목"
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "내용"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: _localController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "지역"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "금액"
                    ),
                    onChanged: (text) {
                      print(text);
                      //_priceController.text = 'W' + text;
                    }
                  ),
                  SizedBox(height: 10,),

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
                        _onSubmit(context);
                      },
                    ),
                  ),


                ]
            ),
          ),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) async {
    var currentLesson = Provider.of<RegisteringLessonProvider>(context, listen: false);

    var params = {
      'bo_table': 'mico_lesson',
      'w': currentLesson.data == null ? '': 'u',
      'wr_id': currentLesson.data == null ? '' : currentLesson.data.wr_id,
      'wr_subject': _subjectController.text,
      'wr_content': _contentController.text,
      'wr_local': _localController.text,
      'wr_price': _priceController.text,
    };
    var res = await request.post(lessonUpdateUrl, body: params);
    print(res.content());

    myLessonsBloc.fetch();
    lessonsBloc.fetch();
    Navigator.pop(context);

  }

  _buildBody() {
    //return Text('hello');

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('리스트뷰 레슨등록 '),
          floating: true,
          //flexibleSpace: Placeholder(),
          //expandedHeight: 20,
        ),
        //Text('hello'),
        /*SliverList(
          delegate: ,
        )*/
      ],
    );
  }


}
