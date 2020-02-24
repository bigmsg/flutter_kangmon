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
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: widget.lesson.portfolio.imgUrl[0],
                  child: Image(
                    height: 200.0,
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage(widget.lesson.portfolio.imgUrl[1]),
                    fit: BoxFit.cover,
                  ),
                ),
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
            Text(widget.lesson.subject),
            Text('${widget.lesson.price}원'),
          ],
        )
    );
  }
}
