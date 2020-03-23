class AcceptedRide {
  final String uid;
  final String acceptedDriverName;
  final String acceptedDriverNumber;
  final String destination;
  final String time;
  final String rate;

  AcceptedRide({
    this.uid,
    this.acceptedDriverName,
    this.acceptedDriverNumber,
    this.destination,
    this.time,
    this.rate,
  });

  AcceptedRide.fromMap(Map snapshot)
      : uid = snapshot['uid'],
        acceptedDriverName = snapshot['acceptedDriverName'],
        acceptedDriverNumber = snapshot['acceptedDriverNumber'],
        destination = snapshot['destination'],
        time = snapshot['time'],
        rate = snapshot['rate'];
}
