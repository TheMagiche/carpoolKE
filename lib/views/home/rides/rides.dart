import 'package:carpoolke/models/request_rides.dart';
import 'package:carpoolke/services/Data/database.dart';
import 'package:carpoolke/views/shared/convert_time.dart';
import 'package:flutter/material.dart';

class RidesComponent extends StatefulWidget {
  @override
  _RidesComponentState createState() => _RidesComponentState();
}

class _RidesComponentState extends State<RidesComponent> {
  bool accept = true;
  List<RequestRides> _requests = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchRequestRides();
  }

  Future<dynamic> fetchRequestRides() async {
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

  deleteRequestRides(String id) async {
    await RequestRidesDataBaseServices().deleteRidesRequest(id);
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
        color: Colors.black,
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
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              radius: 25,
            ),
            title: Text(_requests[index].destination),
            subtitle:
                Text("Time: " + convertTimeTo12Hour(_requests[index].time)),
            trailing: accept == true
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.info,
                  ),
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
    return Scaffold(
        appBar: AppBar(
          title: Text("My Requests"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
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
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _buildRequestList(),
            ),
          ],
        ));
  }
}
