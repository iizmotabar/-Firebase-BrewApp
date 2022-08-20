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
  int sugarIndex = 0;

  double sliderValue = 0.0;
  int sugars = 0;

  final _nameController = TextEditingController();

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
              'Sugars: ${sugarsList[sugarIndex]}',
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
                          if (sugarIndex == sugarsList.length - 1) {
                            sugarIndex = 0;
                          } else {
                            sugarIndex++;
                          }
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
                          if (sugarIndex == 0) {
                            sugarIndex = 0;
                          } else {
                            sugarIndex--;
                          }
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
                label: '${sliderValue.round()}',
                divisions: 10,
                thumbColor: Colors.brown.shade500,
                onChanged: (val) {
                  setState(() {
                    sliderValue = val;
                  });
                }),
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: const Text(
                'Update Preferences',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () async {
                await firestoreService.updateUserData(sugars.toString(),
                    _nameController.text, sliderValue.toInt());
              },
            ),
          ],
        ),
      ),
    );
  }
}
