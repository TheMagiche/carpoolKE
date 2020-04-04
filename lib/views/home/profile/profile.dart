import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';

import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/home/profile/editProfile.dart';
import 'package:carpoolke/views/shared/main_btn.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileComponent extends StatefulWidget {
  final User user;

  const ProfileComponent({Key key, this.user}) : super(key: key);
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> {
  bool isLoading = false;
  UserData userData = UserData();

  final Authservice _auth = Authservice();
  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return EditProfile(
            user: widget.user,
          );
        },
      ));
    }

    return StreamBuilder<UserData>(
      stream: UserDataBaseServices(uid: widget.user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData && isLoading != true) {
          UserData userData = snapshot.data;
          return SafeArea(
            child: Container(
              width: double.infinity,
              height: double.maxFinite,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: Opacity(
                      opacity: 0.7,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/bg.jpg'),
                          ),
                        ),
                      ),
                    ),
                    clipper: GetClipper(),
                  ),
                  Positioned(
                    width: 350.0,
                    top: MediaQuery.of(context).size.height / 6,
                    child: Column(
                      children: <Widget>[
                        userData.userImage == ''
                            ? CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    AssetImage('assets/defaultUser.jpg'))
                            : Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 15.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      // offset: Offset(
                                      //   15.0, // Move to right 10  horizontally
                                      //   15.0, // Move to bottom 10 Vertically
                                      // ),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      userData.userImage,
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(height: 25.0),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'First Name',
                                      style: TextStyle(
                                        fontFamily: 'bradhitc',
                                      ),
                                    ),
                                    Text(userData.fname)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Middle Name',
                                      style: TextStyle(
                                        fontFamily: 'bradhitc',
                                      ),
                                    ),
                                    Text(userData.mname)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Last Name',
                                      style: TextStyle(
                                        fontFamily: 'bradhitc',
                                      ),
                                    ),
                                    Text(userData.lname)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'National ID',
                                      style: TextStyle(
                                        fontFamily: 'bradhitc',
                                      ),
                                    ),
                                    Text(userData.natID)
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Phone number',
                                      style: TextStyle(
                                        fontFamily: 'bradhitc',
                                      ),
                                    ),
                                    Text(userData.phoneNum)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontFamily: 'bradhitc',
                                ),
                              ),
                              Text(userData.userEmail)
                            ],
                          ),
                        ),
                        SizedBox(height: 90.0),
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
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: CarpoolAppBar(
                      screenText: 'Profile',
                      bgColor: Colors.white,
                    ),
                  ),
                  Positioned(
                      top: 80.0,
                      left: 5.0,
                      child: FlatButton(
                        onPressed: _showSettingsPanel,
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 35.0,
                        ),
                      )),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 2.2);
    path.lineTo(size.width + 250, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
