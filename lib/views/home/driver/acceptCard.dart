import 'dart:async';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:flutter/material.dart';
import 'setPrice.dart';

class AcceptCard extends StatefulWidget {
  final String uid;
  final String destination;
  final String time;
  final String requestID;
  AcceptCard(this.uid, this.destination, this.time, this.requestID);
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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
        widget.uid, widget.requestID, widget.destination, widget.time, price);
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop("success");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          // User details
          Container(
            // color: Colors.blueAccent,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/defaultUser.jpg"),
              ),
              title: Text(
                "Name: ",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text(
                    "Branch: ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Year: ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Ride Details -- Destination and Time
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
                ),
              ),
              subtitle: Text(
                "Time : " + convertTimeTo12Hour(widget.time),
                style: TextStyle(
                  color: Colors.white,
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
                price.toString() + " Rs",
                style: TextStyle(color: Colors.white),
              ),
              trailing: FlatButton(
                color: Colors.black,
                textColor: Colors.green,
                child: Text("Set Price"),
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
          SizedBox(height: 40),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              elevation: 3,
              color: Colors.green,
              textColor: Colors.white,
              child: Text(
                "Offer Ride",
                style: TextStyle(
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
