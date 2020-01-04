import 'package:carpoolke/services/auth.dart';
import 'package:carpoolke/views/home/chat/chart.dart';
import 'package:carpoolke/views/home/driver/driver.dart';
import 'package:carpoolke/views/home/profile/profile.dart';
import 'package:carpoolke/views/home/rides/rides.dart';
import 'package:carpoolke/views/home/wallet/wallet.dart';
import 'package:carpoolke/views/shared/myBottomNavItems.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authservice _auth = Authservice();

  ChatComponent chatComponent;
  DriverComponent driverComponent;
  ProfileComponent profileComponent;
  RidesComponent ridesComponent;
  WalletComponent walletComponent;

  int currentTab = 2;
  Widget currentPage;
  List<Widget> pages = [];

  @override
  void initState() {
    chatComponent = ChatComponent();
    driverComponent = DriverComponent();
    profileComponent = ProfileComponent();
    ridesComponent = RidesComponent();
    walletComponent = WalletComponent();

    pages = [
      driverComponent,
      chatComponent,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('CarpoolKe'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_pin),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
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
        color: Colors.red,
        buttonBackgroundColor: Colors.red,
        backgroundColor: Colors.white,
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
