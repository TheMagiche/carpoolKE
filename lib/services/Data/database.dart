import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carpoolke/models/user.dart';

class UserDataBaseServices {
  final String uid;

  UserDataBaseServices({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  Future updateUserData(String fname, String lname, String mname, String natID,
      String phoneNum, String userEmail, String userImage) async {
    return await userCollection.document(uid).setData({
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

  Future addRidesRequest(String uid, String requestID, String departure,
      String destination, String time) async {
    return await requestCollection.add({
      'uid': uid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time
    });
  }

  Future updateRidesRequest(String uid, String requestID, String departure,
      String destination, String time) async {
    return await requestCollection.document(uid).setData({
      'uid': uid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time
    });
  }

  Future<void> deleteRidesRequest(String requestID) async {
    return await requestCollection.document(requestID).delete();
  }
}

class OfferRideRequestDataBaseServices {
  final CollectionReference offerRequestCollection =
      Firestore.instance.collection('OfferRidesRequest');

  Future<QuerySnapshot> getOfferRidesRequest() {
    return offerRequestCollection.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return offerRequestCollection.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String requestedUserID) {
    return offerRequestCollection.document(requestedUserID).get();
  }

  Future addOfferRidesRequest(
      String driverUid,
      String passengerUid,
      String requestID,
      String departure,
      String destination,
      String time,
      String price) async {
    return await offerRequestCollection.add({
      'driverUid': driverUid,
      'passengerUid': passengerUid,
      'requestID': requestID,
      'departure': departure,
      'destination': destination,
      'time': time,
      'price': price
    });
  }

  Future updateOfferRidesRequest(String uid, String requestID,
      String destination, String time, String price) async {
    return await offerRequestCollection.document(uid).setData({
      'uid': uid,
      'requestID': requestID,
      'destination': destination,
      'time': time,
      'price': price
    });
  }

  Future<void> deleteOfferRidesRequest(String requestedUserID) async {
    return await offerRequestCollection.document(requestedUserID).delete();
  }
}

class AcceptedRideRequestDataBaseServices {
  final CollectionReference acceptedRequestCollection =
      Firestore.instance.collection('acceptedRidesRequest');

  Future<QuerySnapshot> getAcceptedRidesRequest() {
    return acceptedRequestCollection.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return acceptedRequestCollection.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String uid) {
    return acceptedRequestCollection.document(uid).get();
  }

  Future addAcceptedRidesRequest(
    String uid,
    String acceptedDriverUid,
    String passengerUid,
    String departure,
    String destination,
    String time,
    String rate,
    String requestID,
    String price,
  ) async {
    return await acceptedRequestCollection.add({
      'uid': uid,
      'acceptedDriverUid': acceptedDriverUid,
      'passengerUid': passengerUid,
      'departure': departure,
      'destination': destination,
      'time': time,
      'rate': rate,
      'requestID': requestID,
      'price': price,
    });
  }

  Future updateAcceptedRidesRequest(
    String uid,
    String acceptedDriverUid,
    String passengerUid,
    String departure,
    String destination,
    String time,
    String rate,
    String requestID,
    String price,
  ) async {
    return await acceptedRequestCollection.document(uid).setData({
      'uid': uid,
      'acceptedDriverUid': acceptedDriverUid,
      'passengerUid': passengerUid,
      'departure': departure,
      'destination': destination,
      'time': time,
      'rate': rate,
      'requestID': requestID,
      'price': price,
    });
  }

  Future<void> deleteAcceptedRidesRequest(String uid) async {
    return await acceptedRequestCollection.document(uid).delete();
  }
}
