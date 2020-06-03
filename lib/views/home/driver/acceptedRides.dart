import 'package:carpoolke/models/accepted_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/home/driver/acceptCard.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
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
    var results =
        await AcceptedRideRequestDataBaseServices().getAcceptedRidesRequest();
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
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AcceptCard(
                  widget.uid,
                  _requests[index].uid,
                  _requests[index].departure,
                  _requests[index].destination,
                  _requests[index].time,
                  _requests[index].requestID)).then((check) {
            if (check == "success") {
              //Show Snackbar
              final snack = SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Notified User!",
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
                    backgroundImage: NetworkImage(userData.userImage),
                    radius: 25,
                  ),
                  title: Text(_requests[index].destination),
                  subtitle: Text(
                      "Time: " + convertTimeTo12Hour(_requests[index].time)),
                  trailing: accept == true
                      ? Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.info,
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
