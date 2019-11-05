import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 152, 42, 1),
        title: Text(
          "Customer Support",
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          shadowColor: Color(0x802196F3),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Having problems?",
                        style: TextStyle(
                            color: Color.fromRGBO(242, 152, 42, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Reach us directly below!",
                        style: TextStyle(
                          color: Color.fromRGBO(242, 152, 42, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ]),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.lightBlueAccent,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          color: Color.fromRGBO(242, 142, 54, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Email:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "    kruuz@gmail.com    ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Container(
                                  margin: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      iconSize: 30.0,
                                      onPressed: () {
                                        _launchUrl(1);
                                      }))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          color: Color.fromRGBO(242, 142, 54, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Phone Number:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "631-704-3924",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    ),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      _launchUrl(2);
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Container(
                          color: Color.fromRGBO(242, 142, 54, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Website:",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "           kruuz.io           ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Container(
                                margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 2.0),
                                ),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print('here');
                                      _launchUrl(3);
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_launchUrl(int option) async {
  switch (option) {
    case 1:
      const url =
          "mailto:kruuz@gmail.com?subject=CustomerSupport&body=Help%20plugin";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Email is invalid";
      }
      break;
    case 2:
      const url = "tel: 6317043294";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Telephone invalid";
      }
      break;
    case 3:
      const url = "https://kruuz.io";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Url invalid";
      }
      break;
    default:
      {
        throw "no option exists for this value";
      }
  }
}
