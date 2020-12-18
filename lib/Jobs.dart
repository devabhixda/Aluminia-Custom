import 'package:aluminia/AddJob.dart';
import 'package:aluminia/Models/User.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Jobs extends StatefulWidget {
  final String userName;
  Jobs({this.userName});
  @override
  _JobsState createState() => _JobsState();
}
class _JobsState extends State<Jobs> {
  double w,h;
  List<Job> jobs;
  Auth auth = new Auth();
  bool loading = true;

  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<Job> temp = await auth.getJobs();
    setState(() {
      jobs = temp;
      loading = false;
    });
  }

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      appBar: AppBar(
        title: Text(
          "Jobs",
          style: GoogleFonts.poppins(
            color: blu,
            fontSize: 32
          ),  
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: loading ? SpinKitDoubleBounce(
          color: blu,
        ) : SingleChildScrollView(
        child: Container(
          height: h,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0.1 * w, vertical: 0.01 * h),
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
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(jobs[index].company,
                                style: GoogleFonts.poppins(
                                  color: blu,
                                  fontSize: 22
                                ),
                              ),
                              Text(jobs[index].description,
                                style: GoogleFonts.poppins(
                                  fontSize: 18
                                ),
                              ),
                              Text("Posted by "+jobs[index].userName+" at "+DateFormat("dd-MM-yyyy hh:mm").format(DateTime.parse(jobs[index].timeStamp)),
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    );
                  }
                ),
              )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddJob(userName: widget.userName))).then((value) => init());
        },
      ),
    );
  }
}