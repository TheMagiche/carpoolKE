import 'package:flutter/material.dart';
import 'package:carpoolke/views/widgets/appbar.dart';
import 'package:carpoolke/models/user.dart';
import 'driver.dart' as first;
import 'acceptedRides.dart' as second;

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
      child: SingleChildScrollView(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CarpoolAppBar(
                screenText: 'Driver\'s Rides',
                bgColor: Colors.white,
              ),
              TabBar(
                  labelStyle: TextStyle(fontFamily: 'Oxygen', fontSize: 12.0),
                  labelColor: Colors.brown,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.dashboard,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      text: 'Offer Rides',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.flag,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      text: 'Accepted Rides',
                    )
                  ]),
              Container(
                height: screenHeight * 0.70,
                child: TabBarView(
                  children: <Widget>[
                    first.DriverComponent(
                      uid: widget.user.uid,
                    ),
                    second.AcceptedRides(uid: widget.user.uid),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
