import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final CollectionReference collection = Firestore.instance.collection("brews");

  DatabaseService({this.uid});

  // create record
  Future updateUserData(String sugur, String name, int strength) async {
    // get  ref and update
    return await collection
        .document(uid)
        .setData({'name': name, 'sugur': sugur, "strength": strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Brew(
            name: doc.data['name'] ?? "",
            sogur: doc.data['sugur'] ?? "",
            strength: doc.data['strength'] ?? 0))
        .toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return collection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return collection.document(uid).snapshots().map(_userDataFormSnapshot);
  }

  UserData _userDataFormSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        strength: snapshot.data['snapshot'],
        sugur: snapshot.data['sogur']);
  }
}
