import 'package:flutter/material.dart';
import 'MyLoadsPage.dart';
import 'NewLoadPage.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/PhotoUpload.dart';
import 'package:kruuz_flutter/Banking.dart';
import 'package:kruuz_flutter/CustomerSupport.dart';
import 'package:kruuz_flutter/Preferences.dart';
import 'package:kruuz_flutter/Schedule.dart';
import 'package:kruuz_flutter/Fleet.dart';

class ShipprHomePage extends StatefulWidget {
  final bool type;
  final String name;
  final String email;
  final String id;
  ShipprHomePage({
    this.type,
    this.name,
    @required this.id,
    this.email,
  });

  @override
  State<StatefulWidget> createState() {
    return _ShipprHomePageState();
  }
}

class _ShipprHomePageState extends State<ShipprHomePage> {
  //methods
  int _currentIndex = 0;
  final List<Widget> _children = [MyLoadsPage(), NewLoadPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //object description
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Kruuz"),
        textTheme: TextTheme(
          title: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('${widget.name}'),
              accountEmail: Text('${widget.email}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.directions_car),
                title: Text('Fleet'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FleetPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.thumb_up),
                title: Text('Preferences'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new PreferencesPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Schedule'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new SchedulePage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Banking'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new BankingPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text('Customer Support'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new CustomerSupportPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.camera_enhance),
                title: Text('Documentation'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhotoPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.keyboard_return),
                title: Text('Logout'),
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).dispatch(
                    LoggedOut(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Color.fromRGBO(242, 152, 54, 1),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.format_list_numbered),
            title: new Text('My Loads'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle_outline),
            title: new Text('Post Load'),
          ),
        ],
      ),
    );
  }
}
