import 'dart:io';
import 'package:aluminia/Services/auth.dart';
import 'package:aluminia/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  final String userName;
  AddPost({this.userName});
  @override
  _AddPostState createState() => _AddPostState();
}
class _AddPostState extends State<AddPost> {
  double w,h;
  File _imageFile;
  String imageUrl, content;
  Auth auth = new Auth();
  final picker = ImagePicker();

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
          "Create Post",
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
          Center(
            child: Container(
              width: 0.7 * w,
              height: 0.2 * h,
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
                child: GestureDetector(
                  onTap: () => {
                    pickImage()
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(image: _imageFile != null ? FileImage(_imageFile) : AssetImage('assets/images/add.png'), fit: BoxFit.contain)
                  )
                ),
              )
            )
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
                    hintText: "Write post here . . . . . . . .",
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
                      content = value;
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
          dynamic post = {
            "user_name": widget.userName,
            "Picture_URl": imageUrl,
            "Content": content,
            "Timestamp": DateTime.now().toString()
          };
          auth.createPost(context, post);
        },
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
}