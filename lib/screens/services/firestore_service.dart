// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brew_app/models/local_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;

  FirestoreService({
    this.uid = '',
  });

//! Collection Reference for the users collection
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Brew Users');

  Future updateUserData(String sugar, String name, int strength) async {
    return await _userCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

//! Get the UserCollection Stream

  Stream<QuerySnapshot> get userCollectionStream {
    //Returns the snapshot of the current user collection
    return _userCollection.snapshots();
  }

  // List<LocalUser> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return LocalUser(
  //         name: doc.get('name') ?? '',
  //         sugars: doc.get('sugars') ?? '0',
  //         strength: doc.get('strength') ?? 0);
  //   }).toList();
  // }
}
