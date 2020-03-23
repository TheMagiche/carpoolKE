// import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/home/chat/chat_users.dart';
// import 'package:carpoolke/views/home/driver/driver.dart';
import 'package:carpoolke/views/home/driver/offerRide.dart';
import 'package:carpoolke/views/home/profile/profile.dart';
import 'package:carpoolke/views/home/rides/findRide.dart';
// import 'package:carpoolke/views/home/rides/rides.dart';
import 'package:carpoolke/views/home/wallet/wallet.dart';
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
  // final Authservice _auth = Authservice();

  ChatUsers chatUsers;
  OfferRide driverComponent;
  ProfileComponent profileComponent;
  // RidesComponent
  FindRide ridesComponent;
  WalletComponent walletComponent;

  int currentTab = 2;
  Widget currentPage;
  List<Widget> pages = [];

  @override
  void initState() {
    chatUsers = ChatUsers();
    driverComponent = OfferRide();
    profileComponent = ProfileComponent(user: widget.user);
    ridesComponent = FindRide();
    walletComponent = WalletComponent();

    pages = [
      driverComponent,
      chatUsers,
      ridesComponent,
      walletComponent,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'CarpoolKe',
          style: TextStyle(
            fontFamily: 'bradhitc',
            fontSize: 25.0,
            color: Colors.red,
          ),
        ),
        actions: <Widget>[],
      ),
      body: currentPage,
      bottomNavigationBar: CurvedNavigationBar(
        index: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.red,
        height: 50.0,
        items: <Widget>[
          MyBottomNavItems(
            myBtnIcon: Icons.airport_shuttle,
            myBtnString: 'Drive',
          ),
          MyBottomNavItems(
            myBtnIcon: Icons.mail,
            myBtnString: 'Chat',
          ),
          MyBottomNavItems(
            myBtnIcon: Icons.search,
            myBtnString: 'Ride',
          ),
          MyBottomNavItems(
            myBtnIcon: Icons.account_balance_wallet,
            myBtnString: 'Wallet',
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
