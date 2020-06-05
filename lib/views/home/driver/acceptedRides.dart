import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/models/accepted_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/shared/phone_call.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';

class AcceptedRides extends StatefulWidget {
  final String uid;
  AcceptedRides({Key key, this.uid}) : super(key: key);

  @override
  _AcceptedRidesState createState() => _AcceptedRidesState();
}

class _AcceptedRidesState extends State<AcceptedRides> {
  bool accept = true;

  // List that contains requests from users
  List<AcceptedRide> _requests = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchOfferRequest();
  }

  Future<dynamic> fetchOfferRequest() async {
    List<AcceptedRide> fetchedRequests = [];
    var results = await AcceptedRideRequestDataBaseServices()
        .getAcceptedDriverRidesRequest(widget.uid);
    fetchedRequests = results.documents
        .map((snapshot) => AcceptedRide.fromMap(snapshot.data))
        .toList();

    setState(() {
      _requests.clear();
      _requests.addAll(fetchedRequests);
      _isLoading = false;
    });
  }

  Future<dynamic> _onRefresh() {
    return fetchOfferRequest();
  }

  Widget _buildRequestList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (BuildContext context, int index) {
          return _requestCards(context, index);
        },
      ),
    );
  }

  // Cards showing user requests
  Widget _requestCards(BuildContext context, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: StreamBuilder(
          stream: UserDataBaseServices(uid: _requests[index].acceptedDriverUid)
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
                        _requests[index].destination,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Oxygen',
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        convertTimeTo12Hour(
                          _requests[index].time,
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
                    _requests[index].price + " Kes",
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
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _buildRequestList();
  }
}
