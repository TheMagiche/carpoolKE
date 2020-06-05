class RequestRides {
  final String uid;
  final String requestID;
  final String departure;
  final String destination;
  final String time;
  final bool isConfirmed;

  RequestRides({
    this.uid,
    this.requestID,
    this.departure,
    this.destination,
    this.time,
    this.isConfirmed,
  });
  RequestRides.fromMap(Map snapshot)
      : uid = snapshot['uid'],
        requestID = snapshot['requestID'],
        departure = snapshot['departure'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        isConfirmed = snapshot['isConfirmed'];
}
