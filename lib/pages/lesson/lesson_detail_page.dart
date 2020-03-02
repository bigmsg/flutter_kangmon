import 'package:flutter/material.dart';
import 'package:flutter_kangmon/data/data.dart';
import 'package:flutter_kangmon/models/lesson.dart';


class LessonDetailPage extends StatefulWidget {
  Lesson lesson;
  LessonDetailPage({this.lesson});

  @override
  _LessonDetailPageState createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  /*Hero(
                    tag: widget.lesson.wr_photos.length > 0 ? widget.lesson.wr_photos[0] : widget.lesson.wr_id.toString(),
                    child:*/ Image(
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      //image: AssetImage(widget.lesson.wr_photos[1]),
                      image: widget.lesson.wr_photos.length > 0 ? NetworkImage(widget.lesson.wr_photos[0]) :  AssetImage('assets/images/1-1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  //),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          color: Colors.red,
                          iconSize: 30.0,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(widget.lesson.wr_subject),
              Text('${widget.lesson.wr_price}원'),
            ],
          ),
        )
    );
  }
}
