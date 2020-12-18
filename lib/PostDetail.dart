import 'package:aluminia/Models/User.dart';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PostDetail extends StatefulWidget {
  final String userName, imgUrl, content;
  final int id;
  PostDetail({this.userName, this.id, this.imgUrl, this.content});
  @override
  _PostDetailState createState() => _PostDetailState();
}
class _PostDetailState extends State<PostDetail> {
  double w,h;
  String comment;
  List<Comment> comments;
  bool commentBox = false, loading = true;
  Auth auth = new Auth();

  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<Comment> temp = await auth.getComments(widget.id);
    setState(() {
      comments = temp;
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
          "Post Detail",
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
              Container(
                width: 0.8 * w,
                height: 0.2 * h,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(image: NetworkImage(widget.imgUrl), fit: BoxFit.fill)
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
                    child: Text(widget.content)
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined),
                      onPressed: () {
                        dynamic like = {
                          "Post_Id": widget.id,
                          "user_name": widget.userName
                        };
                        auth.addLike(like);
                      },
                    ),
                    Text(" Like"),
                    SizedBox(
                      width: 0.2 * w,
                    ),
                    IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        setState(() {
                          commentBox = !commentBox;
                        });
                      },
                    ),
                    Text(" Comment")
                  ],
                )
              ),
              commentBox ? Container(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 0.6 * w,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add comment",
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                          ),
                          onChanged: (value) {
                            setState(() {
                              comment = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            commentBox = false;
                            loading = true;
                          });
                          dynamic cmt = {
                            "Timestamp" : DateTime.now().toString(),
                            "Content": comment,
                            "Post_Id": widget.id,
                            "user_name": widget.userName
                          };
                          auth.addComment(cmt);
                          init();
                        },
                      )
                    ],
                  )
                ),
              ) : Container(),
              Container(
                child: Text("Comments",
                  style: GoogleFonts.poppins(
                    color: blu,
                    fontSize: 20
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 0.1 * w),
                      child: Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Text(comments[index].content)
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Text("Posted by "+comments[index].userName+" at "+DateFormat("dd-MM-yyyy hh:mm").format(DateTime.parse(comments[index].timeStamp)))
                            )
                          ],
                        )
                      )
                    );
                  },
                )
              )
            ],
          )
        ),
      ),
    );
  }
}