import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kruuz_flutter/SplashScreen.dart';
import 'package:kruuz_flutter/HomePage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';

class SingleLoadPage extends StatefulWidget {
  final String loadId;
  SingleLoadPage({
    this.loadId,
  });
  State<StatefulWidget> createState() {
    return _SingleLoadPageState();
  }
}

class _SingleLoadPageState extends State<SingleLoadPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("View Load"),
              textTheme: TextTheme(
                  title: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              )),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: new StreamBuilder(
                stream: Firestore.instance
                    .collection('Load')
                    .document('${widget.loadId}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    print(snapshot.data);
                    return new Text("Loading");
                  }
                  var singleLoad = snapshot.data;
//            print(singleLoad['value']);
                  return new Padding(
                    padding: EdgeInsets.all(10),
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      shadowColor: Color(0x802196F3),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Load Type:',
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${singleLoad['type']}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Current value:',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 40,
                                        color: Color.fromRGBO(242, 152, 42, 1),
                                        child: Text(
                                          '\$ ${singleLoad['value']}',
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Highest current bid:',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 40,
                                    width: 400,
                                    color: Colors.lightBlueAccent,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Pickup on:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${DateTime.fromMillisecondsSinceEpoch(singleLoad['pickupDate'].seconds * 1000)}',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Pickup Address:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${singleLoad['pickupAddress']}',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 400,
                                    color: Color.fromRGBO(242, 152, 54, 1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Dropoff on:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${DateTime.fromMillisecondsSinceEpoch(singleLoad['expirationDate'].seconds * 1000)}',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Dropoff Address:',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${singleLoad['dropoffAddress']}',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Dimensions:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                          'Length: ${singleLoad['length']} FT'),
                                      Text('Width: ${singleLoad['width']} FT'),
                                      Text(
                                          'Height: ${singleLoad['height']} FT'),
                                      Text(
                                          'Weight: ${singleLoad['weight']} LB'),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  new RaisedButton(
                                    child: new Text("Bid",
                                        style: new TextStyle(fontSize: 20.0)),
                                    textColor: Colors.white,
                                    color: Color.fromRGBO(242, 152, 54, 1),
                                    onPressed: () {},
                                  ),
                                  new RaisedButton(
                                    child: new Text("Accept",
                                        style: new TextStyle(fontSize: 20.0)),
                                    color: Colors.lightBlue,
                                    textColor: Colors.white,
                                    onPressed: () async {
                                      await Firestore.instance.runTransaction(
                                          (Transaction tx) async {
                                        DocumentSnapshot postSnapshot =
                                            await tx.get(Firestore.instance
                                                .collection('Load')
                                                .document('${widget.loadId}'));
                                        if (postSnapshot.exists) {
                                          await tx.update(
                                              Firestore.instance
                                                  .collection('Load')
                                                  .document('${widget.loadId}'),
                                              <String, dynamic>{
                                                'trucker':
                                                    '${state.displayName}'
                                              });
                                        }
                                      }).then((onValue) {
                                        Navigator.pop(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
