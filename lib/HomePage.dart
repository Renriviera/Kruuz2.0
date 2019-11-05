import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kruuz_flutter/authentication_bloc/bloc.dart';
import 'Settings.dart';
import 'LoadsPage.dart';
import 'NavigationPageContainer.dart';
import 'DashPage.dart';
import 'PhotoUpload.dart';
import 'Banking.dart';
import 'CustomerSupport.dart';
import 'Preferences.dart';
import 'Schedule.dart';
import 'Fleet.dart';

class HomePage extends StatefulWidget {
  final bool type;
  final String name;
  final String email;
  final String id;
  HomePage({
    Key key,
    this.type,
    @required this.id,
    this.name,
    this.email,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    NavigationPageContainer(),
    DashPage(),
    LoadsPage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //object description
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Authenticated) {
        return Scaffold(
          appBar: new AppBar(
            title: new Text(
              'Kruuz',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            textTheme: TextTheme(
                title: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            )),
            centerTitle: true,
          ),
          body: _children[_currentIndex],
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('${state.displayName}'),
                  accountEmail: Text('${state.displayUserEmail}'),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return new CustomerSupportPage();
                      }));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return new SettingsPage();
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
                icon: new Icon(Icons.map),
                title: new Text('Nav'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text('Dash'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                title: new Text('Loads'),
              ),
            ],
          ),
        );
      }
    });
  }
}
