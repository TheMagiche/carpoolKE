import 'package:flutter/material.dart';
import 'package:carpoolke/views/home/chat/chat.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:carpoolke/models/user.dart';

class ChatCard extends StatefulWidget {
  final String driverUid;
  final String acceptedDriverUid;
  final String passengerUid;
  final String departure;
  final String destination;
  final String time;
  final String rate;
  final String requestID;
  final String price;
  const ChatCard(
      {Key key,
      this.driverUid,
      this.acceptedDriverUid,
      this.passengerUid,
      this.departure,
      this.destination,
      this.time,
      this.rate,
      this.requestID,
      this.price})
      : super(key: key);

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  void initState() {
    super.initState();
  }

  _acceptOffer(BuildContext context) {
    final chatDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => chatDialog,
      barrierDismissible: false,
    );

    _chatWithUser();
  }

  void _chatWithUser() {}
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
                "Offer Ride",
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
