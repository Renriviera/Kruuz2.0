import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:kruuz_flutter/PhotoUpload.dart';
import 'package:kruuz_flutter/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DashPage extends StatefulWidget {
  final String name;
  DashPage({this.name});
  State<StatefulWidget> createState() {
    return _DashState();
  }
}

class _DashState extends State<DashPage> {
  String _dateFormat(DateTime date) {
    return new DateFormat('MMMMEEEEd').format(date);
  }

  String _dateHourFormat(DateTime date) {
    return new DateFormat('jm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
//          print('HERE ${state.displayName}');
          return new Scaffold(
            body: new StreamBuilder(
              stream: Firestore.instance
                  .collection('Load')
                  .where('trucker', isEqualTo: '${state.displayName}')
                  .orderBy('pickupDate', descending: true)
                  .limit(1)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData == null ||
                    snapshot.data == null ||
                    snapshot.data.documents.length == 0) {
                  return new Container(
                    child: Center(
                      child: Text(
                        'No current Loads found!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
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
                  );
                } else {
                  var singleLoad = snapshot.data.documents[0];
//                  print('${singleLoad}');
                  return new Padding(
                    padding: EdgeInsets.all(10),
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      shadowColor: Color(0x802196F3),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      "Current Load",
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                          '${singleLoad['process']}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        color: Color.fromRGBO(242, 152, 41, 1)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
//                                                    '${_now.month}',
                                      '${singleLoad['pickupAddress'].substring(singleLoad['pickupAddress'].indexOf(',') + 1).trim()}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.lightBlueAccent,
                                      size: 30,
                                    ),
                                    Text(
//                                                    '${_now.month}',
                                      '${singleLoad['dropoffAddress'].substring(singleLoad['dropoffAddress'].indexOf(',') + 1).trim()}',
                                      style: TextStyle(
                                        fontSize: 16.0,
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
                                    Text(
//                                                    '${_now.month}',
                                      '${_dateFormat(singleLoad['pickupDate'].toDate())}',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
//                                                    '${_now.month}',
                                      '${_dateFormat(singleLoad['expirationDate'].toDate())}',
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
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.lightBlueAccent,
                                      width: 180.0,
                                      height: 100.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                'Pickup',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Text(
                                              'Location: ${singleLoad['pickupAddress']}'),
                                          Row(
                                            children: <Widget>[
                                              Text('Time: '),
                                              Text(
                                                  '${_dateHourFormat(singleLoad['pickupDate'].toDate())}'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.redAccent,
                                      width: 180.0,
                                      height: 100.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                'Drop off',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Text(
                                              'Location: ${singleLoad['dropoffAddress']}'),
                                          Row(
                                            children: <Widget>[
                                              Text('Time: '),
                                              Text(
                                                  '${_dateHourFormat(singleLoad['expirationDate'].toDate())}'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: 100,
                                width: 500,
                                color: Color.fromRGBO(83, 219, 120, 0.5),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'PRICE:',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('  \$ ${singleLoad['value']}')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'RPM:',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('  \$ 3.49')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Deadhead:',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('  60mi')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Distance:',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                        Text('  229mi')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Type: ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text('${singleLoad['type']}'),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Weight: ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text('${singleLoad['weight']} LB'),
                                    Text('   '),
                                    Text(
                                      'Width: ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text('${singleLoad['width']} FT'),
                                    Text('   '),
                                    Text(
                                      'Length: ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text('${singleLoad['length']} FT'),
                                    Text('   '),
                                    Text(
                                      'Height: ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text('${singleLoad['height']} FT'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text(
                                    'Update Status',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.lightBlueAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UploadPhotoPage(
                                          loadID: singleLoad.documentID,
                                          shipper: singleLoad['shipper'],
                                          trucker: singleLoad['trucker'],
                                          process: singleLoad['process'],
                                        ),
                                      ),
                                    );
                                    //.then((onValue) {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
