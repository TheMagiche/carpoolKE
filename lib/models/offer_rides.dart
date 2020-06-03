class OfferRideRequest {
  final String driverUid;
  final String passengerUid;
  final String requestID;
  final String departure;
  final String destination;
  final String time;
  final String price;

  OfferRideRequest(
      {this.driverUid,
      this.passengerUid,
      this.requestID,
      this.departure,
      this.destination,
      this.time,
      this.price});

  OfferRideRequest.fromMap(Map snapshot)
      : driverUid = snapshot['driverUid'],
        passengerUid = snapshot['passengerUid'],
        requestID = snapshot['requestID'],
        departure = snapshot['departure'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        price = snapshot['price'];
}
