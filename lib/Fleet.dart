import 'package:flutter/material.dart';

class FleetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FleetPageState();
  }
}

class _FleetPageState extends State<FleetPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fleet"),
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
                  const Color.fromRGBO(242, 142, 54, 1),
                  const Color.fromRGBO(232, 152, 44, 0.7)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
