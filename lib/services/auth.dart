import 'package:carpoolke/services/Data/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carpoolke/models/user.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Function to map firebase user object to own user object
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      return User(uid: user.uid);
    } else {
      return null;
    }
  }

  // convert firebase user to own user object
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //login user in firebase email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //register user with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String firstName,
      String lastName,
      String nationalID,
      String phoneNumber) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await UserDataBaseServices(uid: user.uid).updateUserData(
        firstName,
        lastName,
        "Middle Name",
        nationalID,
        phoneNumber,
        email,
        '',
      );
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return null;
    }
  }
}
