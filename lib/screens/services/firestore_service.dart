// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/brew_user.dart';

class FirestoreService {
  final String uid;

  FirestoreService({
    this.uid = '',
  });

//! Collection Reference for the users collection
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Brew Users');

//! Create or a new user in the users collection
  Future updateUserData(String sugar, String name, int strength) async {
    return await _userCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  //! Querysnapshot Reference for the users collection

  List<BrewUser> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BrewUser(
        name: doc.get('name') ?? '',
        sugars: doc.get('sugar') ?? '0',
        strength: doc.get('strength') ?? 0,
      );
    }).toList();
  }
//! Get the UserCollection Stream

  Stream<List<BrewUser>> get userCollectionStream {
    //Returns the snapshot of the current user collection
    return _userCollection.snapshots().map((_brewListFromSnapshot));
  }
}
