import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';

class MyLoadsPage extends StatefulWidget {
  MyLoadsPage();
  State<StatefulWidget> createState() {
    return _MyLoadsPageState();
  }
}

class _MyLoadsPageState extends State<MyLoadsPage> {
  String _dateFormat(DateTime date) {
    return new DateFormat('MMMMEEEEd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Authenticated) {
        print('${state.displayName}');
        return Scaffold(
          body: StreamBuilder(
            stream: Firestore.instance
                .collection('Load')
                .where('shipper', isEqualTo: '${state.displayName}')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading');
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot someLoad = snapshot.data.documents[index];
                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 150.0,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 4.0,
                                  bottom: 4.0,
                                ),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  shadowColor: Color(0x802196F3),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(10.0),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 0.5,
                                                color: Colors.lightBlueAccent),
                                            left: BorderSide(
                                                width: 0.5,
                                                color: Colors.lightBlueAccent),
                                            right: BorderSide(
                                                width: 0.5,
                                                color: Colors.lightBlueAccent),
                                            bottom: BorderSide(
                                                width: 0.5,
                                                color: Colors.lightBlueAccent),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 40.0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
//                                                    '${_now.month}',
                                                    '${someLoad['pickupAddress'].substring(someLoad['pickupAddress'].indexOf(',') + 1).trim()}',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: Colors.lightBlue,
                                                    size: 30,
                                                  ),
                                                  Text(
//                                                    '${_now.month}',
                                                    '${someLoad['dropoffAddress'].substring(someLoad['dropoffAddress'].indexOf(',') + 1).trim()}',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
//                                                    '${_now.month}',
                                                  '${_dateFormat(someLoad['pickupDate'].toDate())}',
                                                  style: TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '\$ ${someLoad['value']}',
                                                  style: TextStyle(
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
//                                                    '${_now.month}',
                                                  '${_dateFormat(someLoad['expirationDate'].toDate())}',
                                                  style: TextStyle(
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        );
      }
    });
  }
}

BoxDecoration LoadDecoration(trucker) {
  if (trucker == "") {
    return BoxDecoration(
      border: Border(
        top: BorderSide(width: 0.5, color: Colors.redAccent),
        left: BorderSide(width: 0.5, color: Colors.redAccent),
        right: BorderSide(width: 0.5, color: Colors.redAccent),
        bottom: BorderSide(width: 0.5, color: Colors.redAccent),
      ),
      color: Colors.white,
    );
  } else {
    return BoxDecoration(
      border: Border(
        top: BorderSide(width: 0.5, color: Colors.lightGreenAccent),
        left: BorderSide(width: 0.5, color: Colors.lightGreenAccent),
        right: BorderSide(width: 0.5, color: Colors.lightGreenAccent),
        bottom: BorderSide(width: 0.5, color: Colors.lightGreenAccent),
      ),
      color: Colors.white,
    );
  }
}
