import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewLoadPage extends StatefulWidget {
  NewLoadPage();
  State<StatefulWidget> createState() {
    return _NewLoadPageState();
  }
}

class _NewLoadPageState extends State<NewLoadPage> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  String dropoff, pickup, type;
  DateTime pickupDate, dropoffDate;
  double length, width, height, weight, price;
  int _myTaskType = 0;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _dropoffDateController = TextEditingController();
//  final TextEditingController _lengthController = TextEditingController();
//  final TextEditingController _widthController = TextEditingController();
//  final TextEditingController _heightController = TextEditingController();
//  final TextEditingController _weightController = TextEditingController();

  _onPickupChanged(pickup) {
    this.pickup = pickup;
  }

  _onDropoffChanged(dropoff) {
    this.dropoff = dropoff;
  }

//  _onPickupDateChanged(pickupDate) {
//    this.pickupDate = pickupDate;
//  }
//
//  _onDropoffDateChanged(dropoffDate) {
//    this.dropoffDate = dropoffDate;
//  }

  _onLengthChanged(length) {
//    double feet = double.parse(length.substring(0, length.indexOf(',')).trim());
//    double inches = double.parse(length.substring(length.indexOf(',')).trim());
//    this.length = feet + (inches / 12.0);
//    print(this.length);
    this.length = double.parse(length);
  }

  _onWidthChanged(width) {
//    double feet = double.parse(width.substring(0, width.indexOf(',')).trim());
//    double inches = double.parse(width.substring(width.indexOf(',')).trim());
//    this.width = feet + (inches / 12.0);
    this.width = double.parse(width);
  }

  _onHeightChanged(height) {
//    double feet = double.parse(height.substring(0, height.indexOf(',')).trim());
//    double inches = double.parse(height.substring(height.indexOf(',')).trim());
//    this.height = feet + (inches / 12.0);
//    print(this.height);
    this.height = double.parse(height);
  }

  _onWeightChanged(weight) {
    this.weight = double.parse(weight);
  }

  _onPriceChanged(price) {
    this.price = double.parse(price);
    print(this.price);
  }

  _createData(name) {
    DocumentReference ds = Firestore.instance.collection('Load').document();
    Map<String, dynamic> loadDetails = {
      "shipper": '${name}',
      "trucker": '',
      "type": type,
      "status": 'open',
      "dropoffAddress": dropoff,
      "pickupAddress": pickup,
      "pickupDate": pickupDate,
      "expirationDate": dropoffDate,
      "length": length,
      "height": height,
      "width": width,
      "weight": weight,
      "value": price,
    };
    ds.setData(loadDetails).whenComplete(() {
      print('Task created');
    });
  }

  void _handleLoadType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          this.type = 'Equipment & Machinery';
          break;
        case 2:
          this.type = 'Freight';
          break;
        case 3:
          this.type = 'Containers';
          break;
      }
    });
    print(this.type);
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Authenticated) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Form(
              key: _formKey1,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('Select Load Type: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _myTaskType,
                            onChanged: _handleLoadType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Equipment & Machinery',
                              style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _myTaskType,
                            onChanged: _handleLoadType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text(
                            'Freight',
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            value: 3,
                            groupValue: _myTaskType,
                            onChanged: _handleLoadType,
                            activeColor: Color(0xff4158ba),
                          ),
                          Text('Container', style: TextStyle(fontSize: 16.0))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 304,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: TextField(
                            controller: _priceController,
                            onChanged: (String price) {
                              _onPriceChanged(price);
                            },
                            decoration: InputDecoration(
                              labelText: "Price: ",
                              hintText: "XXXX.XX",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: TextField(
                            controller: _pickupController,
                            onChanged: (String pickup) {
                              _onPickupChanged(pickup);
                            },
                            decoration: InputDecoration(
                              labelText: "Pickup Address: ",
                              hintText: "# Street, City, State",
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: TextField(
                            controller: _dropoffController,
                            onChanged: (String dropoff) {
                              _onDropoffChanged(dropoff);
                            },
                            decoration: InputDecoration(
                                labelText: "Dropoff Address: ",
                                hintText: "# Street, City, State"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 200.0),
                          child: DateTimeField(
                            controller: _pickupDateController,
                            decoration: InputDecoration(
                              labelText: "Pickup Date: ",
                            ),
                            format: dateFormat,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                pickupDate = DateTimeField.combine(date, time);
                                return DateTimeField.combine(date, time);
                              } else {
                                pickupDate = currentValue;
                                return currentValue;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 200.0),
                          child: DateTimeField(
                            controller: _dropoffDateController,
                            decoration: InputDecoration(
                              labelText: "Dropoff Date: ",
                            ),
                            format: dateFormat,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                dropoffDate = DateTimeField.combine(date, time);
                                return DateTimeField.combine(date, time);
                              } else {
                                dropoffDate = currentValue;
                                return currentValue;
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.lightBlueAccent,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Dimensions',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(242, 152, 54, 1),
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Form(
                                          key: _formKey2,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: TextField(
                                                  onChanged: (String length) {
                                                    _onLengthChanged(length);
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Length: ",
                                                    hintText: 'X',
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: TextField(
                                                  onChanged: (String width) {
                                                    _onWidthChanged(width);
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Width: ',
                                                      hintText: 'X'),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: TextField(
                                                  onChanged: (String height) {
                                                    _onHeightChanged(height);
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Height: ',
                                                      hintText: 'X'),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: TextField(
                                                  onChanged: (String weight) {
                                                    _onWeightChanged(weight);
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Weight: ',
                                                      hintText: 'X'),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: RaisedButton(
                                                  child: Text("Submit"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    print('here');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Dimensions",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RaisedButton(
                              color: Color.fromRGBO(242, 152, 54, 1),
                              onPressed: () {
                                _createData(state.displayName);
                                if (_formKey1.currentState.validate()) {
                                  _formKey1.currentState.save();
                                  _formKey1.currentState.reset();
                                  _pickupController.clear();
                                  _priceController.clear();
                                  _dropoffController.clear();
                                }
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            //here
          ),
        );
      }
    });
  }
}
