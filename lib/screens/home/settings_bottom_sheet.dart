import 'package:brew_app/screens/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../services/auth_service.dart';

class SettingsBottomSheet extends StatefulWidget {
  const SettingsBottomSheet({Key? key}) : super(key: key);

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  late FirestoreService firestoreService = FirestoreService(uid: userId);

  AuthService authService = AuthService();
  final _settingsBottomSheetKey = GlobalKey<FormState>();
  List<String> sugarsList = ['0', '1', '2', '3', '4'];
  int sugars = 1;

  final _sugarController = TextEditingController();
  final _strengthController = TextEditingController();
  final _nameController = TextEditingController();

  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
      child: Form(
        key: _settingsBottomSheetKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                }
                return 'Please enter a valid email';
              },
              controller: _nameController,
              decoration: textInputDecoration.copyWith(labelText: 'Name'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Sugars: $sugars',
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade100,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          sugars += 1;
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade100,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          sugars += -1;
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Brew Strength',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Slider(
                value: sliderValue,
                min: 0.0,
                max: 1000,
                activeColor: Colors.brown,
                inactiveColor: Colors.brown.shade100,
                label: 'Brew Strength',
                divisions: 10,
                thumbColor: Colors.brown.shade500,
                onChanged: (val) {
                  setState(() {
                    sliderValue = val;

                    print(sliderValue);
                  });
                }),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () async {
                await firestoreService.updateUserData(sugars.toString(),
                    _nameController.text, sliderValue.toInt());
                // print(_nameController.text);
                // print('This is null ${_sugarController.text}');
                // print(_strengthController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
