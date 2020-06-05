import 'dart:async';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'setPrice.dart';

class AcceptCard extends StatefulWidget {
  // final String offerID;
  final String driverUid;
  final String passengerUid;
  final String departure;
  final String destination;
  final String time;
  final String requestID;
  AcceptCard(
    // this.offerID,
    this.driverUid,
    this.passengerUid,
    this.departure,
    this.destination,
    this.time,
    this.requestID,
  );
  @override
  _AcceptCardState createState() => _AcceptCardState();
}

class _AcceptCardState extends State<AcceptCard> {
  String price = "0.0";

  @override
  void initState() {
    super.initState();
  }

  _offerRide(BuildContext context) {
    // alertbox
    final alertDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          SizedBox(
            width: 40.0,
          ),
          Text(
            "Notifying user",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    _addPostOfferRequest();
  }

  Future<dynamic> _addPostOfferRequest() async {
    await OfferRideRequestDataBaseServices().addOfferRidesRequest(
      // widget.offerID,
      widget.driverUid,
      widget.passengerUid,
      widget.requestID,
      widget.departure,
      widget.destination,
      widget.time,
      price,
      false,
    );
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop("success");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      height: MediaQuery.of(context).size.height - 100.0,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          // User details
          Container(
            child: StreamBuilder(
              stream: UserDataBaseServices(uid: widget.passengerUid).userData,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                } else {
                  UserData userData = snapshot.data;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userData.userImage),
                    ),
                    title: Text(
                      "First name: " + userData.fname,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Oxygen',
                          fontSize: 12.0),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Last name: " + userData.lname,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oxygen',
                              fontSize: 12.0),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "National ID: " + userData.natID,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Oxygen',
                              fontSize: 12.0),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          // Ride Details -- Destination and Time
          Container(
            // color: Colors.cyan,
            child: ListTile(
              leading: Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              title: Text(
                widget.departure,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Oxygen',
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          Container(
            // color: Colors.cyan,
            child: ListTile(
              leading: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              title: Text(
                widget.destination,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Oxygen',
                  fontSize: 12.0,
                ),
              ),
              subtitle: Text(
                "Time : " + convertTimeTo12Hour(widget.time),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Oxygen',
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          //Set Price
          Container(
            // color: Colors.greenAccent,
            child: ListTile(
              leading: Icon(
                Icons.monetization_on,
                color: Colors.white,
              ),
              title: Text(
                price.toString() + " Kes",
                style: TextStyle(color: Colors.white),
              ),
              trailing: FlatButton(
                color: Colors.white,
                textColor: Colors.red,
                child: Text(
                  "Set Price",
                  style: TextStyle(
                    fontFamily: 'bradhitc',
                    fontSize: 14,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => SetPrice()).then((newPrice) {
                    print(newPrice);
                    setState(() {
                      price = newPrice;
                    });
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              elevation: 3,
              color: Colors.red,
              textColor: Colors.white,
              child: Text(
                "Offer Ride",
                style: TextStyle(
                  fontFamily: 'bradhitc',
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => _offerRide(context),
            ),
          )
        ],
      ),
    );
  }
}
