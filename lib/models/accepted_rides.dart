class AcceptedRide {
  final String acceptID;
  final String acceptedDriverUid;
  final String passengerUid;
  final String departure;
  final String destination;
  final String time;
  final String requestID;
  final String price;

  AcceptedRide({
    this.acceptID,
    this.acceptedDriverUid,
    this.passengerUid,
    this.departure,
    this.destination,
    this.time,
    this.requestID,
    this.price,
  });

  AcceptedRide.fromMap(Map snapshot)
      : acceptID = snapshot['acceptID'],
        acceptedDriverUid = snapshot['acceptedDriverUid'],
        passengerUid = snapshot['passengerUid'],
        departure = snapshot['departure'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        requestID = snapshot['requestID'],
        price = snapshot['price'];
}
