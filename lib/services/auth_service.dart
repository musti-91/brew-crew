import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user Object based on firebase Object
  User _userFromFirebase(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(uid: firebaseUser.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  // Sign Anonymously
  Future signInAnon() async {
    try {
      AuthResult results = await _auth.signInAnonymously();
      FirebaseUser user = results.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future signup(String email, String password) async {
    try {
      dynamic authResult = _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'any_name', 100);

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signin(String email, String password) async {
    try {
      dynamic authResult =
          _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;

      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
    }
  }
}
