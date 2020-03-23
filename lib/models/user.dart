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

  // set _uid(String uid){
  //   this.uid = uid;
  // }

  // set _fname(String fname){
  //   this.fname = fname;
  // }

  // set _lname(String lname){
  //   this.lname = lname;
  // }

  // set _mname(String mname){
  //   this.mname = mname;
  // }

  // set _natID(String natID){
  //   this.natID = natID;
  // }

  // String get _uid => uid;
  // String get _fname => fname;
  // String get _lname => lname;
  // String get _mname => mname;
  // String get _natID => natID;
  // String get _phoneNum => phoneNum;
  // String get _userEmail => userEmail;
  // String get _userImage => userImage;

}
