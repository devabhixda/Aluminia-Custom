import 'package:aluminia/Models/User.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final String userName;
  Profile({this.userName});
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  double w,h;
  String pfp, name, user;
  List<Education> lst;
  List<WorkEx> work;
  Auth auth = new Auth();
  bool loading = true;

  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name");
      pfp = prefs.getString("pfp");
      user = widget.userName;
    });
    List<Education> temp = await auth.getEducation(user);
    List<WorkEx> t2 = await auth.geWorkEx(user);
    setState(() {
      lst = temp;
      work = t2;
      loading = false;
    });
    print(lst.length);
  }

  @override    
  Widget build(BuildContext context) {    
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold( 
      appBar: AppBar(
        title: Text(
          "Profile",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.05 * h),
              child: CircleAvatar(
                radius: 0.1 * h,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(pfp),
              ),
            ),
            Text(name,
              style: GoogleFonts.poppins(
                color: blu,
                fontSize: 32
              ),
            ),
            Container(
              width: w,
              padding: EdgeInsets.only(left: 0.1 * w),
              child: Text("Education",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 20
                ),
              ),
            ),
            for(int index = 0;index<lst.length;index++) 
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0.1 * w, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lst[index].school, 
                          style: GoogleFonts.poppins(
                            color: blu,
                            fontSize: 18
                          ),
                        ),
                        Text(lst[index].degree,
                          style: GoogleFonts.poppins(
                            fontSize: 14
                          ),
                        ),
                        Text(lst[index].percentage.toString())
                      ],
                    ),
                    Text(lst[index].duration)
                  ],
                ),
              )
            ),
            Container(
              width: w,
              padding: EdgeInsets.only(left: 0.1 * w),
              child: Text("Work Experience",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 20
                ),
              ),
            ),
            for(int index = 0;index<work.length;index++) 
            Card(
              margin: EdgeInsets.symmetric(horizontal: 0.1 * w, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0.05 * w, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(work[index].company, 
                          style: GoogleFonts.poppins(
                            color: blu,
                            fontSize: 18
                          ),
                        ),
                        Text(work[index].designation,
                          style: GoogleFonts.poppins(
                            fontSize: 14
                          ),
                        ),
                      ],
                    ),
                    Text(work[index].duration)
                  ],
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}