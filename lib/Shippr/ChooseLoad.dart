import 'package:flutter/material.dart';

class ChooseLoad extends StatefulWidget {
  ChooseLoad();
  State<StatefulWidget> createState() {
    return _ChooseLoadState();
  }
}

class _ChooseLoadState extends State<ChooseLoad> {
  int _myTaskType = 0;
  String type;

  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(children: <Widget>[
          Center(
            child: Text('Select Load Type: ',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
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
                  Text('Freight', style: TextStyle(fontSize: 16.0))
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
        ]),
      ),
    );
  }
}
