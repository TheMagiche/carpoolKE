import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  String uid;
  String fname;
  String lname;
  String mname;
  String natID;
  String phoneNum;
  String userEmail;
  String userImage;

  UserData(
      {this.userImage,
      this.userEmail,
      this.phoneNum,
      this.natID,
      this.mname,
      this.lname,
      this.fname,
      this.uid});

  Map toMap(UserData userData) {
    var data = Map<String, String>();

    data['uid'] = userData.uid;
    data['fname'] = userData.fname;
    data['lname'] = userData.lname;
    data['mname'] = userData.mname;
    data['natID'] = userData.natID;
    data['phoneNum'] = userData.phoneNum;
    data['userEmail'] = userData.userEmail;
    data['userImage'] = userData.userImage;
    return data;
  }

  UserData.fromMap(Map<String, String> mapData) {
    this.uid = mapData['uid'];
    this.fname = mapData['fname'];
    this.lname = mapData['lname'];
    this.mname = mapData['mname'];
    this.natID = mapData['natID'];
    this.phoneNum = mapData['phoneNum'];
    this.userEmail = mapData['userEmail'];
    this.userImage = mapData['userImage'];
  }

  factory UserData.fromDocument(DocumentSnapshot snapshot) {
    return UserData(
      fname: snapshot.data['fname'],
      lname: snapshot.data['lname'],
      mname: snapshot.data['mname'],
      natID: snapshot.data['natID'],
      phoneNum: snapshot.data['phoneNum'],
      userEmail: snapshot.data['userEmail'],
      userImage: snapshot.data['userImage'],
    );
  }
}
