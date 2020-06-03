import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:carpoolke/views/shared/main_btn.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'dart:io';

class EditProfile extends StatefulWidget {
  final User user;

  const EditProfile({Key key, this.user}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  String _fname;
  String _lname;
  String _mname;
  String _natID;
  String _phoneNum;
  String _userImage = '';
  File _image;
  bool isLoading = false;
  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: UserDataBaseServices(uid: widget.user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData && isLoading != true) {
            UserData userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  'Edit profile',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'bradhitc',
                  ),
                ),
                backgroundColor: Colors.white,
              ),
              body: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                _userImage == ''
                                    ? CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: AssetImage(
                                            'assets/defaultUser.jpg'))
                                    : Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(_userImage),
                                          ),
                                        ),
                                      ),
                                RaisedButton(
                                  child: Text(
                                    'Change Image',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Oxygen'),
                                  ),
                                  onPressed: () async {
                                    await ImagePicker.pickImage(
                                            source: ImageSource.gallery)
                                        .then((image) async {
                                      setState(() {
                                        _image = image;
                                      });
                                      StorageReference storageReference =
                                          FirebaseStorage.instance.ref().child(
                                              'profile/${Path.basename(_image.path)}');
                                      StorageUploadTask uploadTask =
                                          storageReference.putFile(_image);
                                      await uploadTask.onComplete;
                                      print('File Uploaded');
                                      await storageReference
                                          .getDownloadURL()
                                          .then((fileURL) {
                                        setState(() {
                                          _userImage = fileURL;
                                          print(_userImage);
                                        });
                                      });
                                    });
                                  },
                                  color: Colors.brown,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: userData.fname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'First Name',
                          suffixIcon: Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 14.0,
                          )),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter first name' : null,
                      onChanged: (val) {
                        setState(() {
                          _fname = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      initialValue: userData.lname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Last Name',
                          suffixIcon: Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 14.0,
                          )),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter last name' : null,
                      onChanged: (val) {
                        setState(() {
                          _lname = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      initialValue: userData.mname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Middle Name',
                          suffixIcon: Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 14.0,
                          )),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter middle name' : null,
                      onChanged: (val) {
                        setState(() {
                          _mname = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      initialValue: userData.natID,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'National ID',
                          suffixIcon: Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 14.0,
                          )),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter National ID' : null,
                      onChanged: (val) {
                        setState(() {
                          _natID = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      initialValue: userData.phoneNum,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Phone Number',
                          suffixIcon: Icon(
                            Icons.border_color,
                            color: Colors.black,
                            size: 14.0,
                          )),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter Phone Number' : null,
                      onChanged: (val) {
                        setState(() {
                          _phoneNum = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    MainButton(
                      text: 'Update Profile',
                      myicon: Icon(Icons.arrow_forward_ios),
                      myFunc: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          await UserDataBaseServices(uid: widget.user.uid)
                              .updateUserData(
                            _fname ?? userData.fname,
                            _lname ?? userData.lname,
                            _mname ?? userData.mname,
                            _natID ?? userData.natID,
                            _phoneNum ?? userData.phoneNum,
                            userData.userEmail ?? userData.userEmail,
                            _userImage ?? userData.userImage,
                          );
                        }

                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 5.0),
                    MainButton(
                      text: 'Log Out',
                      myicon: Icon(Icons.arrow_forward_ios),
                      myFunc: () async {
                        await _auth.signOut();
                      },
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

var textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    alignLabelWithHint: false,
    filled: false,
    enabled: false,
    isDense: false,
    contentPadding: EdgeInsets.all(20.0),
    border: InputBorder.none,
    labelStyle:
        TextStyle(fontFamily: 'bradhitc', fontSize: 20.0, color: Colors.red));
