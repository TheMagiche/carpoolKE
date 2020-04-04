import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/views/home/rides/confirrmCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FindRide extends StatefulWidget {
  @override
  _FindRideState createState() => _FindRideState();
}

class _FindRideState extends State<FindRide> {
  // Destination
  String uid = "";
  String requestID = "";
  String departure = "";
  String destination = "";
  var uuid = Uuid();
  TimeOfDay pickedTime = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay response = await showTimePicker(
      context: context,
      initialTime: pickedTime,
    );
    if (response != null && response != pickedTime) {
      setState(() {
        pickedTime = response;
        print(pickedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Starting Location
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: TextField(
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        hintText: "Departure",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                      onChanged: (String val) {
                        setState(() {
                          departure = val;
                        });
                      },
                    ),
                  ),
                ),
                // Destination
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: TextField(
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        hintText: "Destination",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                      onChanged: (String val) {
                        setState(() {
                          destination = val;
                        });
                      },
                    ),
                  ),
                ),
                // Time
                SizedBox(
                  child: RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child:
                        Text("Select Time", style: TextStyle(fontSize: 16.0)),
                    onPressed: () => _selectTime(context),
                  ),
                ),
                // Confirm button
                SizedBox(
                  child: RaisedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => ConfirmCard(
                                uid: user.uid,
                                departure: departure,
                                destination: destination,
                                requestID: uuid.v1(),
                                time: pickedTime,
                              )).then(
                          (snack) => Scaffold.of(context).showSnackBar(snack));
                    },
                    elevation: 6.0,
                    padding: EdgeInsets.all(10.0),
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      "Find A Ride",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
