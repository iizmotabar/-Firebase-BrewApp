// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:brew_app/screens/services/auth_service.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SignIn build()');
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                widget.toggleView();

                print('Switching to RegisterUser');
              },
              icon: const Icon(Icons.person),
              label: const Text('Register')),
        ],
        backgroundColor: Colors.brown,
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      backgroundColor: Colors.brown.shade100,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      dynamic result =
                          await authService.signInWithEmailAndPassword(
                        userEmail: _emailController.text,
                        userPassword: _passwordController.text,
                      );
                      if (result == null) {
                        print('Something went wrong');
                      } else {
                        if (mounted) {
                          print('Signed in successfully');
                          print('This is the user: ${result.uid}');
                          Navigator.pushNamed(
                            context,
                            '/',
                          );
                        }
                      }
                    },
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Sign in Now!'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
