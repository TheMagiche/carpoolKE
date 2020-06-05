import 'package:carpoolke/models/user.dart';
import 'package:flutter/material.dart';
import 'findRide.dart' as first;
import 'myRides.dart' as third;
import 'rides.dart' as second;
import 'package:carpoolke/views/widgets/appbar.dart';

class RidesPage extends StatefulWidget {
  final User user;

  const RidesPage({Key key, this.user}) : super(key: key);
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
      child: SingleChildScrollView(
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CarpoolAppBar(
                screenText: 'Passenger\'s Rides',
                bgColor: Colors.white,
              ),
              TabBar(
                  labelStyle: TextStyle(fontFamily: 'Oxygen', fontSize: 12.0),
                  labelColor: Colors.brown,
                  tabs: <Widget>[
                    Tab(
                        icon: Icon(
                          Icons.search,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        text: 'Find Ride'),
                    Tab(
                      icon: Icon(
                        Icons.book,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      text: 'Book Ride',
                    ),
                    Tab(
                      icon: Icon(
                        Icons.check_box,
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
                    first.FindRide(),
                    second.RidesComponent(uid: widget.user.uid),
                    third.MyRides(uid: widget.user.uid),
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
