import 'package:flutter/material.dart';
import 'findRide.dart' as first;
import 'myRides.dart' as third;
import 'rides.dart' as second;
import 'package:carpoolke/views/widgets/appbar.dart';

class RidesPage extends StatefulWidget {
  @override
  _RidesPageState createState() => _RidesPageState();
}

class _RidesPageState extends State<RidesPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CarpoolAppBar(
              screenText: 'Passenger\'s Rides',
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
                  Icons.arrow_downward,
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
                  first.FindRide(),
                  second.RidesComponent(),
                  third.MyRides(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
