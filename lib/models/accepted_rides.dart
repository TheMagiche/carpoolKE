class AcceptedRide {
  final String uid;
  final String acceptedDriverUid;
  final String passengerUid;
  final String departure;
  final String destination;
  final String time;
  final String rate;
  final String requestID;
  final String price;

  AcceptedRide({
    this.uid,
    this.acceptedDriverUid,
    this.passengerUid,
    this.departure,
    this.destination,
    this.time,
    this.rate,
    this.requestID,
    this.price,
  });

  AcceptedRide.fromMap(Map snapshot)
      : uid = snapshot['uid'],
        acceptedDriverUid = snapshot['acceptedDriverUid'],
        passengerUid = snapshot['passengerUid'],
        departure = snapshot['departure'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        rate = snapshot['rate'],
        requestID = snapshot['requestID'],
        price = snapshot['price'];
}
