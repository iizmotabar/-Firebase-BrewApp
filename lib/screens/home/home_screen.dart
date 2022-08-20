import 'package:brew_app/screens/services/auth_service.dart';
import 'package:brew_app/screens/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  AuthService authService = AuthService();
  FirestoreService firestoreService = FirestoreService(uid: '');

  @override
  Widget build(BuildContext context) {
    // Stream Provider is of type Querysnapshot as the firebase stream returns query snapshots
    return StreamProvider<QuerySnapshot?>.value(
      value: firestoreService.userCollectionStream,
      initialData: null,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton.icon(
                onPressed: () async {
                  await authService.signout();
                },
                icon: const Icon(Icons.person),
                label: const Text('SignOut')),
          ],
          centerTitle: true,
          title: const Text(
            'Brew App',
          ),
        ),
        body: const BrewList(),
      ),
    );
  }
}
