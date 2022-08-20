import 'package:brew_app/models/local_user.dart';
import 'package:brew_app/screens/authenticate/authenticate.dart';
import 'package:brew_app/screens/home/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return HomeScreen();
    }
  }

  // print(user.uid);

  // final FirebaseAuth auth = FirebaseAuth.instance;

  //! Return Either the HomeScreen or the Authenticate screen

}
