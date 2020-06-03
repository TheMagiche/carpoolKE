import 'package:flutter/material.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/models/user.dart';
import 'offerRide.dart' as first;
import 'driver.dart' as second;

class DriversPage extends StatefulWidget {
  final User user;

  const DriversPage({Key key, this.user}) : super(key: key);

  @override
  _DriversPageState createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      child: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CarpoolAppBar(
              screenText: 'Driver\'s Rides',
              bgColor: Colors.white,
            ),
            TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.arrow_back,
                  size: 25.0,
                  color: Colors.red,
                ),
              ),
              Tab(
                  icon: Icon(
                Icons.arrow_forward,
                size: 25.0,
                color: Colors.red,
              ))
            ]),
            Container(
              height: screenHeight * 0.70,
              child: TabBarView(
                children: <Widget>[
                  first.OfferRide(
                    user: widget.user,
                  ),
                  second.DriverComponent(uid: widget.user.uid),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
