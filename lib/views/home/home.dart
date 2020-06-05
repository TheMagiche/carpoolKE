import 'package:carpoolke/views/home/driver/driversPage.dart';
import 'package:carpoolke/views/home/profile/profile.dart';
import 'package:carpoolke/views/home/rides/ridesPage.dart';
import 'package:carpoolke/views/shared/myBottomNavItems.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:carpoolke/models/user.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DriversPage driverComponent;
  ProfileComponent profileComponent;
  RidesPage ridesComponent;

  int currentTab = 1;
  Widget currentPage;
  List<Widget> pages = [];

  @override
  void initState() {
    driverComponent = DriversPage(user: widget.user);
    profileComponent = ProfileComponent(user: widget.user);
    ridesComponent = RidesPage(user: widget.user);

    pages = [
      driverComponent,
      ridesComponent,
      profileComponent,
    ];
    currentPage = ridesComponent;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: currentPage,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        color: Colors.red,
        buttonBackgroundColor: Colors.brown,
        backgroundColor: Colors.white,
        height: 50.0,
        items: <Widget>[
          MyBottomNavItems(
            myBtnIcon: Icons.airport_shuttle,
            myBtnString: 'Drive',
          ),
          MyBottomNavItems(
            myBtnIcon: Icons.accessibility_new,
            myBtnString: 'Ride',
          ),
          MyBottomNavItems(
            myBtnIcon: Icons.person,
            myBtnString: 'Profile',
          ),
        ],
      ),
    );
  }
}
