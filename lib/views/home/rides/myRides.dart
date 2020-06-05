import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:carpoolke/models/accepted_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/views/shared/phone_call.dart';

class MyRides extends StatefulWidget {
  final String uid;

  const MyRides({Key key, this.uid}) : super(key: key);

  @override
  _MyRidesState createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  // List that contains requests from users
  List<AcceptedRide> _rides = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAcceptedRides();
  }

  Future<dynamic> fetchAcceptedRides() async {
    List<AcceptedRide> fetchedRequests = [];
    var results = await AcceptedRideRequestDataBaseServices()
        .getAcceptedPassengerRidesRequest(widget.uid);
    fetchedRequests = results.documents
        .map((snapshot) => AcceptedRide.fromMap(snapshot.data))
        .toList();

    setState(() {
      _rides.clear();
      _rides.addAll(fetchedRequests);
      _isLoading = false;
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchAcceptedRides();
  }

  Widget _buildRidesList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _rides.length,
              itemBuilder: (BuildContext context, int index) {
                return _ridesCards(context, index);
              },
            ),
          )
        ],
      ),
    );
  }

  // Cards showing accepted rides
  Widget _ridesCards(BuildContext context, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: StreamBuilder(
          stream: UserDataBaseServices(uid: _rides[index].acceptedDriverUid)
              .userData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              UserData userData = snapshot.data;
              return ExpansionTile(
                leading: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(userData.userImage),
                  radius: 25,
                ),
                title: ListTile(
                  title: Text(
                    userData.fname + ' ' + userData.lname,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Oxygen',
                      fontSize: 12.0,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _rides[index].destination,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Oxygen',
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        convertTimeTo12Hour(
                          _rides[index].time,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Oxygen',
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  child: Text(
                    _rides[index].price + " Kes",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'bradhitc',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                children: <Widget>[
                  ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: Colors.brown,
                      ),
                      title: GestureDetector(child: Text(userData.phoneNum)),
                      onTap: () => openPhone(userData.phoneNum))
                ],
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildRidesList(),
          ),
        ],
      ),
    );
  }
}
