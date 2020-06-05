import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpoolke/models/offer_rides.dart';
import 'package:carpoolke/models/user.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/home/rides/chatCardUser.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:carpoolke/views/widgets/loading.dart';
import 'package:flutter/material.dart';

class RidesComponent extends StatefulWidget {
  final String uid;

  const RidesComponent({Key key, this.uid}) : super(key: key);
  @override
  _RidesComponentState createState() => _RidesComponentState();
}

class _RidesComponentState extends State<RidesComponent> {
  bool accept = false;
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
    var results = await OfferRideRequestDataBaseServices()
        .getOfferRidesRequest(widget.uid);
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
                            ),
                          )
                        : RaisedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => UserChatCard(
                                        offerID: _requests[index].offerID,
                                        acceptedDriverUid:
                                            _requests[index].driverUid,
                                        passengerUid:
                                            _requests[index].passengerUid,
                                        departure: _requests[index].departure,
                                        destination:
                                            _requests[index].destination,
                                        requestID: _requests[index].requestID,
                                        time: _requests[index].time,
                                        price: _requests[index].price,
                                      )).then((snack) =>
                                  Scaffold.of(context).showSnackBar(snack));
                            },
                            elevation: 6.0,
                            padding: EdgeInsets.all(2.0),
                            color: Colors.brown,
                            textColor: Colors.white,
                            child: Text(
                              'Preview',
                              style: TextStyle(
                                  fontFamily: 'bradhitc',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ));
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
            bottom: 30,
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
