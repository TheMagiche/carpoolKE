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
  var uuid = Uuid();

  String uid = "";
  String departure = "";
  String destination = "";
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
    return Stack(
      children: <Widget>[
        Center(
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
                        leading: Icon(
                          Icons.location_on,
                          size: 18.0,
                        ),
                        title: TextField(
                          style: TextStyle(fontSize: 13.0),
                          decoration: InputDecoration(
                            hintText: "Departure",
                            labelStyle: TextStyle(fontFamily: 'Oxygen'),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
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
                        leading: Icon(
                          Icons.add_location,
                          size: 18.0,
                        ),
                        title: TextField(
                          style: TextStyle(fontSize: 13.0),
                          decoration: InputDecoration(
                            hintText: "Destination",
                            labelStyle: TextStyle(fontFamily: 'Oxygen'),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
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
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text("Select Time",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'bradhitc',
                            )),
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
                                    time: pickedTime,
                                  )).then((snack) =>
                              Scaffold.of(context).showSnackBar(snack));
                        },
                        elevation: 6.0,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.brown,
                        textColor: Colors.white,
                        child: Text(
                          "Find A Ride",
                          style: TextStyle(
                              fontFamily: 'bradhitc',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
