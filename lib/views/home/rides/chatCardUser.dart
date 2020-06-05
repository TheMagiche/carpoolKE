import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:carpoolke/models/user.dart';

class UserChatCard extends StatefulWidget {
  final String offerID;
  final String acceptedDriverUid;
  final String passengerUid;
  final String departure;
  final String destination;
  final String time;
  final String requestID;
  final String price;

  UserChatCard({
    this.offerID,
    this.acceptedDriverUid,
    this.passengerUid,
    this.departure,
    this.destination,
    this.time,
    this.requestID,
    this.price,
  });

  @override
  _UserChatCardState createState() => _UserChatCardState();
}

class _UserChatCardState extends State<UserChatCard> {
  Future<dynamic> _addAcceptRequest(SnackBar snack) async {
    await AcceptedRideRequestDataBaseServices().addAcceptedRidesRequest(
      widget.acceptedDriverUid,
      widget.passengerUid,
      widget.departure,
      widget.destination,
      widget.time,
      widget.requestID,
      widget.price,
    );

    await RequestRidesDataBaseServices().updateRidesRequest(
      widget.passengerUid,
      widget.requestID,
      widget.departure,
      widget.destination,
      widget.time,
      true,
    );

    await OfferRideRequestDataBaseServices().updateOfferRidesRequest(
      widget.offerID,
      widget.acceptedDriverUid,
      widget.passengerUid,
      widget.requestID,
      widget.departure,
      widget.destination,
      widget.time,
      widget.price,
      true,
    );

    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop("success");
    });
  }

  void _acceptOffer(BuildContext context) {
    final chatDialog = AlertDialog(
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
            "Sending Request",
            style: TextStyle(fontFamily: 'bradhitc', color: Colors.brown),
          )
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => chatDialog,
      barrierDismissible: false,
    );

    // Snackbar
    final snack = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Request has been successfully sent!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 4),
    );

    _addAcceptRequest(snack);
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
              stream:
                  UserDataBaseServices(uid: widget.acceptedDriverUid).userData,
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
                      "Driver name: " + userData.fname + ' ' + userData.lname,
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
                          "Phone: " + userData.phoneNum,
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
                    color: Colors.white, fontFamily: 'Oxygen', fontSize: 12.0),
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
                    color: Colors.white, fontFamily: 'Oxygen', fontSize: 12.0),
              ),
              subtitle: Text(
                "Time : " + convertTimeTo12Hour(widget.time),
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Oxygen', fontSize: 12.0),
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
                widget.price + " Kes",
                style: TextStyle(color: Colors.white),
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
                "Accept Offer",
                style: TextStyle(
                  fontFamily: 'bradhitc',
                  fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => _acceptOffer(context),
            ),
          )
        ],
      ),
    );
  }
}
