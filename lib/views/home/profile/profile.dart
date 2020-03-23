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

class ProfileComponent extends StatefulWidget {
  final User user;

  const ProfileComponent({Key key, this.user}) : super(key: key);
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  final _formKey = GlobalKey<FormState>();

  String _fname;
  String _lname;
  String _mname;
  String _natID;
  String _phoneNum;
  String _userImage;
  File _image;
  bool isLoading = false;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  final Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: UserDataBaseServices(uid: widget.user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData && isLoading != true) {
            UserData userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                userData.userImage == ''
                                    ? CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage: AssetImage(
                                            'assets/defaultUser.jpg'))
                                    : CircleAvatar(
                                        radius: 80.0,
                                        backgroundImage:
                                            NetworkImage(userData.userImage),
                                      ),
                              ],
                            )),
                          ),
                          _image == null
                              ? RaisedButton(
                                  child: Text('Choose File'),
                                  onPressed: chooseFile,
                                  color: Colors.red,
                                )
                              : Container(
                                  child: Text('Select Image'),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.fname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'First Name',
                          prefixIcon: Icon(
                            Icons.add_box,
                            color: Colors.red,
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
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.lname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Last Name',
                          prefixIcon: Icon(
                            Icons.add_box,
                            color: Colors.red,
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
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.mname,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Middle Name',
                          prefixIcon: Icon(
                            Icons.add_box,
                            color: Colors.red,
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
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.natID,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'National ID',
                          prefixIcon: Icon(
                            Icons.add_box,
                            color: Colors.red,
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
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: userData.phoneNum,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(
                            Icons.add_box,
                            color: Colors.red,
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
                      height: 10.0,
                    ),
                    MainButton(
                      text: 'Update Profile',
                      myicon: Icon(Icons.arrow_forward_ios),
                      myFunc: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          StorageReference storageReference = FirebaseStorage
                              .instance
                              .ref()
                              .child('profile/${Path.basename(_image.path)}');
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
                              UserDataBaseServices(uid: widget.user.uid)
                                  .updateUserData(
                                _fname ?? userData.fname,
                                _lname ?? userData.lname,
                                _mname ?? userData.mname,
                                _natID ?? userData.natID,
                                _phoneNum ?? userData.phoneNum,
                                userData.userEmail ?? userData.userEmail,
                                _userImage ?? userData.userImage,
                              );
                            });
                          });

                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    MainButton(
                      text: 'Logout',
                      myFunc: () async {
                        await _auth.signOut();
                      },
                      myicon: Icon(Icons.account_circle),
                    ),
                    SizedBox(height: 50.0),
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
