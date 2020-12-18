import 'dart:io';
import 'package:aluminia/Models/User.dart';
import 'package:aluminia/Screens/OnBoarding/Education.dart' as Edu;
import 'package:aluminia/const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Auth{
  createAccount(BuildContext context, user) async {
    String url = server + "/User";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(user), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", user["user_name"]);
    await prefs.setString("pfp", user["Profile_Image_URL"]);
    await prefs.setString("name", user["Name"]);
    await prefs.setBool('login', true);
    if(response.statusCode == 200) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Edu.Education(userName: user["user_name"])));
    }
  }

  addEducation(education) async {
    print(education);
    String url = server + "/Education";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(education), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
  }

  Future<bool> signIn(String user_name, String password) async {
    String url = server + "/User" + "/$user_name";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    if(data[0]["Password"] == password) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_name", user_name);
      await prefs.setString("pfp", data[0]["Profile_Image_URL"]);
      await prefs.setString("name", data[0]["Name"]);
      await prefs.setBool('login', true);
      return true;
    }
    return false;
  }


  Future<String> uploadImage(File _imageFile) async {
    print(_imageFile.hashCode);
    final ref = FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(_imageFile.hashCode.toString());
    if (_imageFile != null) {
      await ref.putFile(_imageFile);
      return await ref.getDownloadURL();
    } 
    return "";
  }

  getUser(String user_name) async {
    String url = server + "/User" + "/$user_name";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
  }

  addWorkEx(workex) async {
    String url = server + "/Work_Experience";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(workex), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
  }

  Future<List<Education>> getEducation(String user) async {
    String url = server + "/Education" + "/$user";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    List<Education> lst = [];
    for(int i=0;i<data.length;i++) {
      Education e = new Education(school: data[i]["School_Name"], degree: data[i]["Degree"], duration: data[i]["Duration"], percentage: data[i]["Percentage"]);
      lst.add(e);
    }
    return lst;
  }

  Future<List<WorkEx>> geWorkEx(String user) async {
    String url = server + "/Work_Experience" + "/$user";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    List<WorkEx> lst = [];
    for(int i=0;i<data.length;i++) {
      WorkEx e = new WorkEx(company: data[i]["Company"], designation: data[i]["Designation"], duration: data[i]["Duration"]);
      lst.add(e);
    }
    return lst;
  }

  createPost(BuildContext context, postcon) async {
    String url = server + "/Post";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(postcon), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
    if(response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Post added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: blu,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
  }

  Future<List<Post>> getPosts() async {
    String url = server + "/Post";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    List<Post> lst = [];
    for(int i=0;i<data.length;i++) {
      Post e = new Post(id: data[i]["Post_Id"], imgUrl: data[i]["Picture_URL"], content: data[i]["Content"], timeStamp: data[i]["Timestamp"]);
      lst.add(e);
    }
    return lst;
  }

  addLike(like) async {
    String url = server + "/Likes";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(like), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
  }

  addComment(comment) async {
    String url = server + "/Comment";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(comment), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
    if(response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Comment added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: blu,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<List<Comment>> getComments(int id) async {
    String url = server + "/Comment/$id";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    List<Comment> lst = [];
    for(int i=0;i<data.length;i++) {
      Comment e = new Comment(content: data[i]["Content"], userName: data[i]["user_name"], timeStamp: data[i]["Timestamp"]);
      lst.add(e);
    }
    return lst;
  }

  Future<List<Job>> getJobs() async {
    String url = server + "/Job";
    Response response = await get(Uri.encodeFull(url));
    var data = json.decode(response.body);
    List<Job> lst = [];
    for(int i=0;i<data.length;i++) {
      Job e = new Job(company: data[i]["Company"],description: data[i]["Description"], timeStamp: data[i]["Timestamp"], userName: data[i]["user_name"]);
      lst.add(e);
    }
    return lst;
  }

  createJob(BuildContext context, job) async {
    String url = server + "/Job";
    Response response = await post(Uri.encodeFull(url), 
      body: json.encode(job), 
      headers: {
        "Content-Type": "application/json",
        "Connection": "Keep-Alive"
      },
    );
    if(response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Job added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: blu,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pop(context);
    }
  }
}