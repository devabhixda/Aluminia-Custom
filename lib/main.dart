import 'package:aluminia/Screens/OnBoarding/Login.dart';
import 'package:aluminia/base.dart';
import 'package:aluminia/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Aluminia()
    );
  }
}

class Aluminia extends StatefulWidget {
  @override
  _AluminiaState createState() => _AluminiaState();
}

class _AluminiaState extends State<Aluminia> {

  bool loading = true, login = false;

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() { 
      setState(() {
        loading = false;
      });
    });
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    bool _login = prefs.getBool('login');
    if(_login != null) {
      setState(() {
        login = _login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: loading ? SpinKitDoubleBounce(
          color: blu,
        )  : login ? Base() : Login()
      ),
    );
  }
}