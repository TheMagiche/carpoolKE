import 'package:carpoolke/models/offer_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';

class RidesComponent extends StatefulWidget {
  @override
  _RidesComponentState createState() => _RidesComponentState();
}

class _RidesComponentState extends State<RidesComponent> {
  bool accept = true;
  List<OfferRideRequest> _requests = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRequestRides();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> fetchRequestRides() async {
    List<OfferRideRequest> fetchedRequests = [];
    var results =
        await OfferRideRequestDataBaseServices().getOfferRidesRequest();
    fetchedRequests = results.documents
        .map((snapshot) => OfferRideRequest.fromMap(snapshot.data))
        .toList();

    setState(() {
      _requests.clear();
      _requests.addAll(fetchedRequests);
      _isLoading = false;
    });
  }

  deleteRequestRides(String id) async {
    await OfferRideRequestDataBaseServices().deleteOfferRidesRequest(id);
  }

  Future<dynamic> _onRefresh() {
    return fetchRequestRides();
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
    return Dismissible(
      key: Key(UniqueKey().toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.brown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Icon(Icons.delete, color: Colors.white),
          ],
        ),
      ),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: StreamBuilder(
            stream:
                UserDataBaseServices(uid: _requests[index].driverUid).userData,
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
      confirmDismiss: (DismissDirection direction) async {
        final bool res = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Confirm"),
                content: Text("Are you sure you wish to delete this request?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("delete"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  FlatButton(
                    child: Text("cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              );
            });
        return res;
      },
      onDismissed: (direction) {
        //send a delete request
        String requestId = _requests[index].requestID;
        deleteRequestRides(requestId);

        setState(() {
          _requests.removeAt(index);
        });

        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Request deleted"),
          backgroundColor: Colors.black,
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 25,
            left: 0.0,
            right: 0.0,
            child: Container(
              child: Center(
                child: Text(
                  "Swipe to delete",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildRequestList(),
          ),
        ],
      ),
    );
  }
}
