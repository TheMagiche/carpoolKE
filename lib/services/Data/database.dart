import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpoolke/models/user.dart';

class UserDataBaseServices {
  final String uid;

  UserDataBaseServices({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  Future updateUserData(String fname, String lname, String mname, String natID,
      String phoneNum, String userEmail, String userImage) async {
    return await userCollection.document(uid).updateData({
      'fname': fname,
      'lname': lname,
      'mname': mname,
      'natID': natID,
      'phoneNum': phoneNum,
      'userEmail': userEmail,
      'userImage': userImage,
    });
  }

  UserData _userDataFromSnapshotData(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.data['fname'],
      lname: snapshot.data['lname'],
      mname: snapshot.data['mname'],
      natID: snapshot.data['natID'],
      phoneNum: snapshot.data['phoneNum'],
      userEmail: snapshot.data['userEmail'],
      userImage: snapshot.data['userImage'],
    );
  }

  Stream<UserData> get userData {
    return userCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshotData);
  }
}

class RequestRidesDataBaseServices {
  final CollectionReference requestCollection =
      Firestore.instance.collection('ridesRequest');

  Future<QuerySnapshot> getOfferRidesRequest() {
    return requestCollection.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return requestCollection.snapshots();
  }

  Future addRidesRequest(
    String uid,
    String departure,
    String destination,
    String time,
    bool isConfirmed,
  ) async {
    return await requestCollection.add({
      'uid': uid,
      'departure': departure,
      'destination': destination,
      'time': time,
      'isConfirmed': isConfirmed,
    }).then((value) => value.updateData({'requestID': value.documentID}));
  }

  Future updateRidesRequest(
    String uid,
    String requestID,
    String departure,
    String destination,
    String time,
    bool isConfirmed,
  ) async {
    return await requestCollection.document(requestID).updateData({
      'uid': uid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time,
      'isConfirmed': isConfirmed,
    });
  }

  Future<void> deleteRidesRequest(String requestID) async {
    return await requestCollection.document(requestID).delete();
  }
}

class OfferRideRequestDataBaseServices {
  final CollectionReference offerRequestCollection =
      Firestore.instance.collection('OfferRidesRequest');

  Future<QuerySnapshot> getAllOfferRidesRequest() {
    return offerRequestCollection.getDocuments();
  }

  Future<QuerySnapshot> getOfferRidesRequest(String passengerUid) {
    return offerRequestCollection
        .where('passengerUid', isEqualTo: passengerUid)
        .getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return offerRequestCollection.snapshots();
  }

  Future addOfferRidesRequest(
    String driverUid,
    String passengerUid,
    String requestID,
    String departure,
    String destination,
    String time,
    String price,
    bool isConfirmed,
  ) async {
    return await offerRequestCollection.add({
      'driverUid': driverUid,
      'passengerUid': passengerUid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time,
      'price': price,
      'isConfirmed': isConfirmed,
    }).then((value) => value.updateData({'offerID': value.documentID}));
  }

  Future updateOfferRidesRequest(
    String offerID,
    String driverUid,
    String passengerUid,
    String requestID,
    String departure,
    String destination,
    String time,
    String price,
    bool isConfirmed,
  ) async {
    return await offerRequestCollection.document(offerID).updateData({
      'offerID': offerID,
      'driverUid': driverUid,
      'passengerUid': passengerUid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time,
      'price': price,
      'isConfirmed': isConfirmed,
    });
  }

  Future<void> deleteOfferRidesRequest(String offerID) async {
    return await offerRequestCollection.document(offerID).delete();
  }
}

class AcceptedRideRequestDataBaseServices {
  final CollectionReference acceptedRequestCollection =
      Firestore.instance.collection('acceptedRidesRequest');

  Future<QuerySnapshot> getAcceptedRidesRequest() {
    return acceptedRequestCollection.getDocuments();
  }

  Future<QuerySnapshot> getAcceptedDriverRidesRequest(String driverUid) {
    return acceptedRequestCollection
        .where('acceptedDriverUid', isEqualTo: driverUid)
        .getDocuments();
  }

  Future<QuerySnapshot> getAcceptedPassengerRidesRequest(String passengerUid) {
    return acceptedRequestCollection
        .where('passengerUid', isEqualTo: passengerUid)
        .getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return acceptedRequestCollection.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String acceptID) {
    return acceptedRequestCollection.document('acceptID').get();
  }

  Future addAcceptedRidesRequest(
    String acceptedDriverUid,
    String passengerUid,
    String departure,
    String destination,
    String time,
    String requestID,
    String price,
  ) async {
    return await acceptedRequestCollection.add({
      'acceptedDriverUid': acceptedDriverUid,
      'passengerUid': passengerUid,
      'departure': departure,
      'destination': destination,
      'time': time,
      'requestID': requestID,
      'price': price,
    }).then((value) => value.updateData({'acceptID': value.documentID}));
  }

  Future updateAcceptedRidesRequest(
    String acceptID,
    String acceptedDriverUid,
    String passengerUid,
    String departure,
    String destination,
    String time,
    String requestID,
    String price,
  ) async {
    return await acceptedRequestCollection.document('acceptID').updateData({
      'acceptID': acceptID,
      'acceptedDriverUid': acceptedDriverUid,
      'passengerUid': passengerUid,
      'departure': departure,
      'destination': destination,
      'time': time,
      'requestID': requestID,
      'price': price,
    });
  }

  Future<void> deleteAcceptedRidesRequest(String acceptID) async {
    return await acceptedRequestCollection.document('acceptID').delete();
  }
}
