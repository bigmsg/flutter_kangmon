import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String message) async {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String result = await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context, "OK");
            },
          ),
          /*FlatButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context, "Cancel");
            },
          ),*/
        ],
      );
    },
  );

  scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text("Result: $result"),
        backgroundColor: Colors.orange,
        action: SnackBarAction(
          label: "Done",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
}