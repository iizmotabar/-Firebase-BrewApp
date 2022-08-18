import 'package:brew_app/screens/authenticate/register_user.dart';
import 'package:flutter/material.dart';

import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignIn = true;

  void toggleViewFunction() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return SignIn(toggleView: toggleViewFunction);
    } else {
      return RegisterUser(toggleView: toggleViewFunction);
    }
  }
}
