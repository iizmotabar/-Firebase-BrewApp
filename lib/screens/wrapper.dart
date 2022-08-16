import 'package:brew_app/screens/authenticate/authenticate.dart';
import 'package:brew_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    //! Return Either the HomeScreen or the Authenticate screen
    return auth.currentUser != null ? const HomeScreen() : const Authenticate();
  }
}
