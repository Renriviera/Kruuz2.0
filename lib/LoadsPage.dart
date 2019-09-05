import 'package:flutter/material.dart';
import 'package:kruuz_flutter/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kruuz_flutter/Loads/SingleLoad.dart';

class LoadsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadsPageState();
  }
}

class _LoadsPageState extends State<LoadsPage> {
//  List<String> _products = ['Laptop'];
  String loadId = '';
  String _dateFormat(DateTime date) {
    return new DateFormat('MMMMEEEEd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider.value(
      value: BlocProvider.of<AuthenticationBloc>(context),
      child: Scaffold(
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('Load')
              .where('trucker', isEqualTo: '')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading');
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot someLoad = snapshot.data.documents[index];
                  loadId = snapshot.data.documents[index].documentID;
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
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
//                                                    '${_now.month}',
                                                '${someLoad['pickupAddress'].substring(someLoad['pickupAddress'].indexOf(',') + 1).trim()}',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
//                                                    '${_now.month}',
                                                '${someLoad['dropoffAddress'].substring(someLoad['dropoffAddress'].indexOf(',') + 1).trim()}',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new IconButton(
                                              icon: Icon(Icons.arrow_drop_down),
                                              iconSize: 30.0,
                                              color: Colors.lightBlue,
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return new SingleLoadPage(
                                                    loadId: someLoad.documentID,
                                                  );
                                                }));
                                              },
                                            ),
                                            new IconButton(
                                              icon: Icon(Icons.arrow_drop_down),
                                              iconSize: 30.0,
                                              color: Colors.lightBlue,
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return new SingleLoadPage(
                                                    loadId: someLoad.documentID,
                                                  );
                                                }));
                                              },
                                            ),
                                            new IconButton(
                                              icon: Icon(Icons.arrow_drop_down),
                                              iconSize: 30.0,
                                              color: Colors.lightBlue,
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return new SingleLoadPage(
                                                    loadId: someLoad.documentID,
                                                  );
                                                }));
                                              },
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
                        ],
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
