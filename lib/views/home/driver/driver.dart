import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/models/request_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/home/driver/acceptCard.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DriverComponent extends StatefulWidget {
  final String uid;
  DriverComponent({Key key, this.uid}) : super(key: key);

  @override
  _DriverComponentState createState() => _DriverComponentState();
}

class _DriverComponentState extends State<DriverComponent> {
  var uuid = Uuid();
  // List that contains requests from users
  List<RequestRides> _requests = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchOfferRequest();
  }

  Future<dynamic> fetchOfferRequest() async {
    List<RequestRides> fetchedRequests = [];
    var results = await RequestRidesDataBaseServices().getOfferRidesRequest();
    fetchedRequests = results.documents
        .map((snapshot) => RequestRides.fromMap(snapshot.data))
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
      child: GestureDetector(
        onTap: () {
          if (_requests[index].isConfirmed) {
          } else {
            showModalBottomSheet(
                context: context,
                builder: (context) => AcceptCard(
                      // uuid.v1(),
                      widget.uid,
                      _requests[index].uid,
                      _requests[index].departure,
                      _requests[index].destination,
                      _requests[index].time,
                      _requests[index].requestID,
                    )).then((check) {
              if (check == "success") {
                //Show Snackbar
                final snack = SnackBar(
                  backgroundColor: Colors.brown,
                  content: Text(
                    "Added Offer!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  duration: Duration(seconds: 4),
                );
                Scaffold.of(context).showSnackBar(snack);
              }
            }).catchError((e) {
              print(e);
            });
          }
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream: UserDataBaseServices(uid: _requests[index].uid).userData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              } else {
                UserData userData = snapshot.data;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(userData.userImage),
                    radius: 25,
                  ),
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
                  trailing: _requests[index].isConfirmed
                      ? Text(
                          'Completed',
                          style: TextStyle(
                            fontFamily: 'bradhitc',
                            fontSize: 12.0,
                          ),
                        )
                      : Text(
                          'View Ride',
                          style: TextStyle(
                            fontFamily: 'bradhitc',
                            fontSize: 12.0,
                          ),
                        ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _buildRequestList();
  }
}
