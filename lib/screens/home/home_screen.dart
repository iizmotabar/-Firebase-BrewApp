import 'package:brew_app/models/brew_user.dart';
import 'package:brew_app/screens/services/auth_service.dart';
import 'package:brew_app/screens/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import 'brew_list.dart';
import 'settings_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  AuthService authService = AuthService();
  FirestoreService firestoreService = FirestoreService(uid: '');

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const SettingsBottomSheet();
        },
      );
    }

    // Stream Provider is of type Querysnapshot as the firebase stream returns query snapshots
    return StreamProvider<List<BrewUser?>>.value(
      value: firestoreService.userCollectionStream,
      initialData: const [],
      catchError: (_, __) => [],
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(100, 20)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(left: 5.0))),
              onPressed: () {
                showSettingsPanel();
              },
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
            ),
            ElevatedButton.icon(
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(100, 20)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.only(right: 5.0)),
                ),
                onPressed: () async {
                  await authService.signout();
                },
                icon: const Icon(Icons.person),
                label: const Text('SignOut')),
          ],
          // centerTitle: true,
          title: const Text(
            'Brew App',
          ),
        ),
        body: const BrewList(),
      ),
    );
  }
}
