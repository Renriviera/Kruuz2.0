import 'package:flutter/material.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Preferences"),
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        )),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(3, 252, 232, 0.8),
                const Color.fromRGBO(3, 136, 252, 0.4)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
