import 'package:aluminia/Connections.dart';
import 'package:aluminia/Home.dart';
import 'package:aluminia/Jobs.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}
class _BaseState extends State<Base> {
  double w,h;
  int selected = 1;
  String userName;
  List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    setLogin();
  }

  
  setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("user_name");
      _widgetOptions  = [Jobs(userName: userName), Home(userName: userName), Connections(userName: userName)];
    });
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _widgetOptions == null ? SpinKitDoubleBounce(
        color: blu,
      ) : _widgetOptions.elementAt(selected),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: blu,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: selected,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: ""
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }
}