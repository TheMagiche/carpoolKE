class OfferRideRequest {
  final String offerID;
  final String driverUid;
  final String passengerUid;
  final String requestID;
  final String departure;
  final String destination;
  final String time;
  final String price;
  final bool isConfirmed;

  OfferRideRequest({
    this.offerID,
    this.driverUid,
    this.passengerUid,
    this.requestID,
    this.departure,
    this.destination,
    this.time,
    this.price,
    this.isConfirmed,
  });

  OfferRideRequest.fromMap(Map snapshot)
      : offerID = snapshot['offerID'],
        driverUid = snapshot['driverUid'],
        passengerUid = snapshot['passengerUid'],
        requestID = snapshot['requestID'],
        departure = snapshot['departure'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        price = snapshot['price'],
        isConfirmed = snapshot['isConfirmed'];
}
