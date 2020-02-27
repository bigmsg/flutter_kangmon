import 'package:flutter/material.dart';


class LessonContentRegisterPage extends StatelessWidget {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TextEditingController _localController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('레슨등록'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _subjectController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "내용"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: _localController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "지역"
                    ),
                  ),
                  SizedBox(height: 10,),

                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
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

  void _onSubmit(context) {
    print('저장하기 ');
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
