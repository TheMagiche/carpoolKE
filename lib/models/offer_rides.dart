class OfferRideRequest {
  final String uid;
  final String requestID;
  final String destination;
  final String time;
  final String price;

  OfferRideRequest(
      {this.uid, this.requestID, this.destination, this.time, this.price});

  OfferRideRequest.fromMap(Map snapshot)
      : uid = snapshot['uid'],
        requestID = snapshot['requestID'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        price = snapshot['price'];
}
