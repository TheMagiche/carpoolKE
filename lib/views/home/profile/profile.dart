import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';

import 'package:carpoolke/views/home/profile/editProfile.dart';

import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:carpoolke/views/widgets/radialPosition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RadialListViewModel {
  final List<RadialListItemViewModel> items;

  RadialListViewModel({this.items = const []});
}

class RadialListItemViewModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  RadialListItemViewModel(
      {this.icon,
      this.title = '',
      this.subtitle = '',
      this.isSelected = false});
}

class SlidingRadialList extends StatelessWidget {
  final RadialListViewModel radialList;
  final SlidingRadialListController slidingListController;

  SlidingRadialList({Key key, this.radialList, this.slidingListController})
      : super(key: key);

  List<Widget> _radialListItems() {
    // final double firstItemAngle = -pi / 3;
    // final double lastItemAngle = pi / 3;
    // final double angleDiffPerItem =
    //     (lastItemAngle - firstItemAngle) / (radialList.items.length - 1);

    // double currentAngle = firstItemAngle;

    int index = 0;
    return radialList.items.map((RadialListItemViewModel viewModel) {
      final listItem = _radialListItem(
        viewModel,
        slidingListController.getItemAngle(index),
        slidingListController.getItemOpacity(index),
      );
      // currentAngle += angleDiffPerItem;
      ++index;
      return listItem;
    }).toList();
  }

  Widget _radialListItem(
      RadialListItemViewModel viewModel, double angle, double opacity) {
    return Transform(
      transform: Matrix4.translationValues(40.0, 334.0, 0.0),
      child: RadialPosition(
        radius: 130.0 + 70.0,
        angle: angle,
        child: Opacity(
          opacity: opacity,
          child: RadialListItem(
            listItem: viewModel,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingListController,
        builder: (BuildContext context, Widget child) {
          return Stack(
            children: _radialListItems(),
          );
        });
  }
}

class RadialListItem extends StatelessWidget {
  final RadialListItemViewModel listItem;

  RadialListItem({Key key, this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final circleDecoration = listItem.isSelected
        ? BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.brown,
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.brown,
            border: Border.all(
              color: Colors.brown,
              width: 2.0,
            ));

    return Transform(
      transform: Matrix4.translationValues(-30.0, -30.0, 0.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: circleDecoration,
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Icon(
                listItem.icon,
                size: 15.0,
                color: listItem.isSelected ? Colors.black : Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  listItem.title,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                Text(
                  listItem.subtitle,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    fontFamily: 'bradhitc',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileComponent extends StatefulWidget {
  final User user;

  const ProfileComponent({Key key, this.user}) : super(key: key);
  @override
  _ProfileComponentState createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent>
    with TickerProviderStateMixin {
  bool isLoading = false;
  UserData userData = UserData();
  SlidingRadialListController slidingListController;

  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  @override
  void initState() {
    super.initState();
    slidingListController =
        SlidingRadialListController(itemCount: 6, vsync: this)
          ..addListener(() => setState(() {}))
          ..open();
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
          return Container(
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 250.0, left: 10.0),
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
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: 2.0, //extend the shadow
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
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ),
                ),
                SlidingRadialList(
                    radialList: RadialListViewModel(items: [
                      RadialListItemViewModel(
                          icon: Icons.account_circle,
                          title: 'First Name',
                          subtitle: userData.fname),
                      RadialListItemViewModel(
                          icon: Icons.account_circle,
                          title: 'Middle Name',
                          subtitle: userData.mname),
                      RadialListItemViewModel(
                          icon: Icons.account_box,
                          title: 'Last Name',
                          subtitle: userData.lname),
                      RadialListItemViewModel(
                          icon: Icons.contact_phone,
                          title: 'Phone Number',
                          subtitle: userData.phoneNum),
                      RadialListItemViewModel(
                          icon: Icons.contacts,
                          title: 'National ID',
                          subtitle: userData.natID),
                      RadialListItemViewModel(
                          icon: Icons.email,
                          title: 'Email',
                          subtitle: userData.userEmail),
                    ]),
                    slidingListController: slidingListController),
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

class SlidingRadialListController extends ChangeNotifier {
  final double firstItemAngle = -pi / 3;
  final double lastItemAngle = pi / 3;
  final double startSlidingAngle = 3 * pi / 4;

  final AnimationController _slideController;
  final AnimationController _fadeController;
  final int itemCount;
  final List<Animation<double>> _slidePositions;

  RadialListState _state = RadialListState.closed;
  Completer<Null> onOpenedCompleter;
  Completer<Null> onClosedCompleter;

  SlidingRadialListController({
    vsync,
    this.itemCount,
  })  : _slideController = AnimationController(
          vsync: vsync,
          duration: Duration(milliseconds: 1500),
        ),
        _fadeController = AnimationController(
          vsync: vsync,
          duration: Duration(milliseconds: 150),
        ),
        _slidePositions = [] {
    _slideController
      ..addListener(() => notifyListeners())
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = RadialListState.slidingOpen;
            notifyListeners();
            break;
          case AnimationStatus.completed:
            _state = RadialListState.open;
            notifyListeners();
            onOpenedCompleter.complete();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.dismissed:
            break;
        }
      });
    _fadeController
      ..addListener(() => notifyListeners())
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = RadialListState.fadingOut;
            notifyListeners();
            break;
          case AnimationStatus.completed:
            _state = RadialListState.closed;
            _slideController.value = 0.0;
            _fadeController.value = 0.0;
            notifyListeners();
            onClosedCompleter.complete();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.dismissed:
            break;
        }
      });

    final delayedInterval = 0.1;
    final slideInterval = 0.5;
    final angleDeltaPerItem =
        (lastItemAngle - firstItemAngle) / (itemCount - 1);

    for (var i = 0; i < itemCount; ++i) {
      final start = delayedInterval * i;
      final end = start + slideInterval;
      final endSlideAngle = firstItemAngle + (angleDeltaPerItem * i);

      _slidePositions.add(
          new Tween(begin: startSlidingAngle, end: endSlideAngle).animate(
              new CurvedAnimation(
                  parent: _slideController,
                  curve: Interval(start, end, curve: Curves.easeInOut))));
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  double getItemAngle(int index) {
    return _slidePositions[index].value;
  }

  double getItemOpacity(int index) {
    switch (_state) {
      case RadialListState.closed:
        return 0.0;
        break;
      case RadialListState.slidingOpen:
      case RadialListState.open:
        return 1.0;
        break;
      case RadialListState.fadingOut:
        return (1.0 - _fadeController.value);
        break;
      default:
        return 1.0;
    }
  }

  Future<Null> open() {
    if (_state == RadialListState.closed) {
      _slideController.forward();
      onOpenedCompleter = Completer();
      return onOpenedCompleter.future;
    }
    return null;
  }

  Future<Null> close() {
    if (_state == RadialListState.open) {
      _fadeController.forward();
      onClosedCompleter = Completer();
      return onClosedCompleter.future;
    }
    return null;
  }
}

enum RadialListState {
  open,
  slidingOpen,
  closed,
  fadingOut,
}
