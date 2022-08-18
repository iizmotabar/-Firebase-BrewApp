// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:brew_app/screens/services/auth_service.dart';

class RegisterUser extends StatefulWidget {
  final Function toggleView;
  const RegisterUser({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  @override
  Widget build(BuildContext context) {
    print('RegisterUser build()');

    AuthService authService = AuthService();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
              onPressed: () => widget.toggleView(),
              icon: const Icon(Icons.person),
              label: const Text('Sign In')),
        ],
        backgroundColor: Colors.brown,
        title: const Text('Register'),
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Name',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
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
                          await authService.createUserWithEmailAndPassword(
                        userEmail: emailController.text,
                        userPassword: passwordController.text,
                      );
                      if (result != null) {
                        print('User Created Successfully');
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Text('User Successfully signed up!'),
                        );
                      }
                    },
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Register Now!'),
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
