import 'package:aluminia/Home.dart';
import 'package:aluminia/Screens/OnBoarding/WorkEx.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/base.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class WorkEx extends StatefulWidget {
  final String userName;
  WorkEx({this.userName});
  @override
  _WorkExState createState() => _WorkExState();
}

class WorkExParameters {
  String company;
  String designation;
  String startDate;
  String endDate;
  WorkExParameters(this.company, this.designation, this.startDate, this.endDate);
}

class _WorkExState extends State<WorkEx> {
  var list = List<WorkExParameters>();
  WorkExParameters edu = new WorkExParameters("Company","Designation","Start","End");
  int count = 0;
  Auth auth = new Auth();
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
          "Work Experience",
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
                    height: 0.35 * h,
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
                                  hintText: list[index].company,
                                  hintStyle:GoogleFonts.poppins(color: Colors.grey, fontSize: 18)
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    list[index].company = value;
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
                                  hintText: list[index].designation,
                                  hintStyle:GoogleFonts.poppins(color: Colors.grey, fontSize: 18)
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    list[index].designation = value;
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
                      addWorkEx(false);
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
                addWorkEx(true);
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

  addWorkEx(bool next) async {
    setState(() {
      loading = true;
    });
    dynamic workEx = {
      "user_name": widget.userName,
      "Company": list[count].company,
      "Designation": list[count].designation,
      "Duration": list[count].startDate+" to "+list[count].endDate,
    };
    print(workEx);
    setState(() {
      count++;
    });
    list.add(new WorkExParameters("Comapany","Designation","Start","End"));
    await auth.addWorkEx(workEx);
    if(next) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Base()));
    }
    setState(() {
      loading = false;
    });
  }
}