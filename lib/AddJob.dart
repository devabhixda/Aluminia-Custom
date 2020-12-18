import 'dart:io';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddJob extends StatefulWidget {
  final String userName;
  AddJob({this.userName});
  @override
  _AddJobState createState() => _AddJobState();
}
class _AddJobState extends State<AddJob> {
  double w,h;
  String company, desc;
  Auth auth = new Auth();

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
          "Create Job",
          style: GoogleFonts.poppins(
            color: blu,
            fontSize: 32
          ),  
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.15 * w, vertical: 0.015 * h),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.blue,
                  blurRadius: 10.0,
                  spreadRadius: -8
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Company",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                  onChanged: (value) {
                    setState(() {
                      company= value;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 0.3 * h,
            margin: EdgeInsets.symmetric(horizontal: 0.15 * w, vertical: 0.015 * h),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.blue,
                  blurRadius: 10.0,
                  spreadRadius: -8
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Job description",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  maxLines: 10,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                  ),
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          dynamic job = {
            "user_name": widget.userName,
            "Company": company,
            "Description": desc,
            "Timestamp": DateTime.now().toString()
          };
          auth.createJob(context, job);
        },
      ),
    );
  }
}