import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final String uid;

  FirestoreService({required this.uid});
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
}
