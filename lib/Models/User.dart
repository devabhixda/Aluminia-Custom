class Education{
  String school;
  String degree;
  int percentage;
  String duration;
  Education({this.school, this.degree, this.duration, this.percentage});
}

class WorkEx{
  String company;
  String designation;
  String duration;
  WorkEx({this.company, this.designation, this.duration});
}

class Post{
  int id;
  String imgUrl;
  String content;
  String timeStamp;
  Post({this.id, this.imgUrl, this.content, this.timeStamp});
}

class Comment{
  String content;
  String userName;
  String timeStamp;
  Comment({this.content, this.userName, this.timeStamp});
}

class Job {
  String description;
  String timeStamp;
  String userName;
  String company;
  Job({this.description, this.timeStamp, this.userName, this.company});
}