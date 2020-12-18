import 'dart:io';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  double h,w;
  String email, ptemp, password, emailError = "", ptempError = "", passwordError = "";
  String name, contact, gender, imageUrl, pickedDate, type;
  Auth auth = new Auth();
  File _imageFile;
  final picker = ImagePicker();
  int _radiobtnvalue1 = -1, _radiobtnvalue2 = -1;
  dynamic user;
  bool loading = false;

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      body: loading ? SpinKitDoubleBounce(
        color: blu,
        size: 30.0,
      ) : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.1 * h,
            ),
            Center(
              child: Text("Join the network!",
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  color: blu
                )
              ),
            ),
            Center(
              child: Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: blu,
                shape: CircleBorder(),
                child: GestureDetector(
                  onTap: () => {
                    pickImage()
                  },
                  child: CircleAvatar(
                    radius: 0.1 * h,
                    backgroundColor: Colors.white,
                    backgroundImage: _imageFile != null ? FileImage(_imageFile) : AssetImage('assets/images/add.png'),
                  ),
                ),
              )
            ),
            SizedBox(
              height: 0.05 * h,
            ),
            textInput("Email", false),
            Text(
              emailError, style: TextStyle(fontSize: 12, color: Colors.red)
            ),
            textInput("Password", true),
            Text(
              ptempError, style: TextStyle(fontSize: 12, color: Colors.red)
            ),
            textInput("Confirm Password", true),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                addRadio2(0, 'Student'),
                addRadio2(1, 'Faculty'),
                addRadio2(2, 'Alumini'),
              ],
            ),
            Text(
              passwordError, style: TextStyle(fontSize: 12, color: Colors.red)
            ),
            textInput("Name", false),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0.1 * w, vertical: 0.015 * h),
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Colors.blue,
                    blurRadius: 15.0,
                    spreadRadius: -10
                  ),
                ],
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: pickedDate == null ? Text("D.O.B",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey
                      ),
                    ): Text(pickedDate,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_down),
                    onTap: _pickDate,
                  ),
                ),
              ),
            ),
            textInput("Contact", false),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                addRadio1(0, 'Male'),
                addRadio1(1, 'Female'),
                addRadio1(2, 'Other'),
              ],
            ),
            SizedBox(
              height: 0.05 * h,
            ),
            FloatingActionButton(
              onPressed: () => {
                print("press"),
                if(email == null  || !EmailValidator.validate(email)) {
                  setState(() {
                    emailError = "Please enter a valid email";
                  })
                } else if(ptemp == null) {
                  setState(() {
                    emailError = "";
                    ptempError = "Password cannot be empty";
                  })
                } else if(ptemp != password) {
                  setState(() {
                    ptempError = "";
                    passwordError = "Password mismatch";
                  })
                } else {
                  setState(() {
                    emailError = "";
                    ptempError = "";
                    passwordError = "";
                    loading = true;
                  }),
                  user = {
                    "user_name": email.split("@")[0],
                    "Name": name,
                    "Profile_Image_URL": imageUrl,
                    "User_Type": type,
                    "Gender": gender,
                    "birthdate": pickedDate,
                    "Mobile_Number": contact,
                    "Email": email,
                    "Password": password
                  },
                  auth.createAccount(context, user)
                }
              },
              backgroundColor: blu,
              tooltip: "SignUp",
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              ),
            ),
            SizedBox(
              height: 0.05 * h,
            )
          ],
        ),
      )
    );
  }
  Widget textInput(String hintText, bool obscure) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.1 * w, vertical: 0.015 * h),
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
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 18
              )
            ),
            obscureText: obscure,
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
            onChanged: (value) {
              setState(() {
                if(hintText == "Email") 
                  this.email = value;
                if(hintText == "Password")
                  this.ptemp = value;
                if(hintText == "Confirm Password")
                  this.password = value;
                if(hintText == "Name") 
                  this.name = value;
                if(hintText == "Contact")
                  this.contact = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
    String imgUrl = await auth.uploadImage(_imageFile);
    setState(() {
      imageUrl = imgUrl;
    });
  }
  _pickDate() async {
   DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: DateTime.now(),
    );

    if(date != null)
      setState(() {
        pickedDate = DateFormat('yyyy-MM-dd').format(date);
      });
  }
  Row addRadio1(int btnValue, String title) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        activeColor: blu,
        value: btnValue,
        groupValue: _radiobtnvalue1,
        onChanged: _handleradiobutton1,
      ),
      Text(title,
        style: GoogleFonts.poppins(
          fontSize: 16
        ),
      )
    ],
    );
  }

  void _handleradiobutton1(int value) {
    setState(() {
      _radiobtnvalue1 = value;
      switch (value) {
        case 0:
          gender = "m";
          break;
        case 1:
          gender = "f";
          break;
        case 2:
          gender = 'o';
          break;
        default:
          gender = null;
      }
    });
  }

  Row addRadio2(int btnValue, String title) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Radio(
        activeColor: blu,
        value: btnValue,
        groupValue: _radiobtnvalue2,
        onChanged: _handleradiobutton2,
      ),
      Text(title,
        style: GoogleFonts.poppins(
          fontSize: 16
        ),
      )
    ],
    );
  }

  void _handleradiobutton2(int value) {
    setState(() {
      _radiobtnvalue2 = value;
      switch (value) {
        case 0:
          type = "Student";
          break;
        case 1:
          type = "Faculty";
          break;
        case 2:
          type = "Alumini";
          break;
        default:
          gender = null;
      }
    });
  }
}