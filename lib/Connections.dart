import 'dart:io';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Connections extends StatefulWidget {
  final String userName;
  Connections({this.userName});
  @override
  _ConnectionsState createState() => _ConnectionsState();
}
class _ConnectionsState extends State<Connections> {
  double w,h;

  void initState() {
    super.initState();
    print(widget.userName);
  }

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      appBar: AppBar(
        title: Text(
          "Connections",
          style: GoogleFonts.poppins(
            color: blu,
            fontSize: 32
          ),  
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}