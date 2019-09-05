import 'package:flutter/material.dart';

//potentially marked for deletion

class DialogBox {
  information(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[Text(description)],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                      return Navigator.pop(context);
                    })
              ]);
        });
  }
}
