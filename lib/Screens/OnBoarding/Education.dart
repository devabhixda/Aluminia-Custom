import 'package:aluminia/Screens/OnBoarding/WorkEx.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Education extends StatefulWidget {
  final String userName;
  Education({this.userName});
  @override
  _EducationState createState() => _EducationState();
}

class EducationParameters {
  String school;
  String degree;
  String startDate;
  String endDate;
  String percentage;
  EducationParameters(this.school, this.degree, this.startDate, this.endDate, this.percentage);
}

class _EducationState extends State<Education> {
  var list = List<EducationParameters>();
  EducationParameters edu = new EducationParameters("School Name","Degree","Start","End","Percentage");
  int count = 0;
  Auth auth = new Auth();
  String schoolName, degree, start, end, percentage;
  bool loading = false;

  void initState() {
    super.initState();
    list.add(edu);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Education History",
          style: GoogleFonts.poppins(color: blu, fontSize: 32),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: !loading ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 0.7 * h,
              child: ListView.builder(
                itemCount: count+1,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    height: 0.45 * h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: new BoxDecoration(
                            boxShadow: [
                              new BoxShadow(color: Colors.blue, blurRadius: 10.0, spreadRadius: -8),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: list[index].school,
                                  hintStyle:GoogleFonts.poppins(color: Colors.grey, fontSize: 18)
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    list[index].school = value;
                                  });
                                },
                              )
                            )
                          )
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: new BoxDecoration(
                            boxShadow: [
                              new BoxShadow(color: Colors.blue, blurRadius: 10.0, spreadRadius: -8),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: list[index].degree,
                                  hintStyle:GoogleFonts.poppins(color: Colors.grey, fontSize: 18)
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    list[index].degree = value;
                                  });
                                },
                              )
                            )
                          )
                        ),
                        Row(
                          children: [
                            Container(
                              width: 0.4 * w,
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Text(
                                      list[index].startDate,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 18
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onTap: () {
                                    _pickDate("start", index);
                                  },
                                )
                              ),
                            ),
                            Container(
                              width: 0.4 * w,
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                child: GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Text(
                                      list[index].endDate,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 18
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  onTap: () {
                                    _pickDate("end", index);
                                  },
                                )
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: new BoxDecoration(
                            boxShadow: [
                              new BoxShadow(color: Colors.blue, blurRadius: 10.0, spreadRadius: -8),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: list[index].percentage,
                                  hintStyle:GoogleFonts.poppins(color: Colors.grey, fontSize: 18)
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    list[index].percentage = value;
                                  });
                                },
                              )
                            )
                          )
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  count > 0 ? GestureDetector(
                    onTap: () {
                      setState(() {
                        count--;
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(Icons.remove,color: blu,),
                        Text("Clear",
                          style: GoogleFonts.poppins(
                            color: blu, fontSize: 22
                          ),
                        ),
                      ],
                    ),
                  ) : SizedBox(),
                  GestureDetector(
                    onTap: () {
                      addEducation(false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.add, color: blu,),
                        Text("Add New",
                          style: GoogleFonts.poppins(
                            color: blu, fontSize: 22
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ]  
              ),
            FloatingActionButton(
              onPressed: () {
                addEducation(true);
              },
              backgroundColor: blu,
              tooltip: "Next",
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )
      ) : SpinKitDoubleBounce(
        color: blu,
      )
    );
  }

  _pickDate(String which, int index) async {
    DateTime date = await showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        which == "start" ? list[index].startDate = DateFormat("MM-yyyy").format(date) : list[index].endDate = DateFormat("MM-yyyy").format(date);
      });
    } 
  }

  addEducation(bool next) async {
    setState(() {
      loading = true;
    });
    dynamic education = {
      "user_name": widget.userName,
      "School_Name": list[count].school,
      "Degree": list[count].degree,
      "Duration": list[count].startDate+" to "+list[count].endDate,
      "Percentage": list[count].percentage
    };
    setState(() {
      count++;
    });
    list.add(new EducationParameters("School Name","Degree","Start","End","Percentage"));
    await auth.addEducation(education);
    if(next) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WorkEx(userName: widget.userName,)));
    }
    setState(() {
      loading = false;
    });
  }
}