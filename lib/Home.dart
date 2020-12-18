import 'package:aluminia/AddPost.dart';
import 'package:aluminia/Models/User.dart';
import 'package:aluminia/PostDetail.dart';
import 'package:aluminia/Profile.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final String userName;
  Home({this.userName});
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  double w,h;
  String comment;
  Auth auth = new Auth();
  List<Post> posts;
  bool commentBox = false, loading = true;

  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<Post> temp = await auth.getPosts();
    setState(() {
      posts = temp;
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
          "Aluminia",
          style: GoogleFonts.poppins(
            color: blu,
            fontSize: 32
          ),  
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 0.05 * w),
            child: GestureDetector(
              child: CircleAvatar(
                child: Icon(Icons.person),
                backgroundColor: blu,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(userName: widget.userName,)));
              },
            )
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: loading ? SpinKitDoubleBounce(
        color: blu,
      ) : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 0.1 * h),
              height: 0.95 * h,
              child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail(userName: widget.userName, id: posts[index].id, imgUrl: posts[index].imgUrl, content: posts[index].content)));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          width: 0.8 * w,
                          height: 0.2 * h,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(image: NetworkImage(posts[index].imgUrl), fit: BoxFit.fill)
                            ),
                          )
                        ),
                        Container(
                          width: 0.8 * w,
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Text(posts[index].content)
                            )
                          )
                        ),
                      ],
                    ),
                  )
                );
              }
            )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPost(userName: widget.userName,)));
        },
      ),
    );
  }
}