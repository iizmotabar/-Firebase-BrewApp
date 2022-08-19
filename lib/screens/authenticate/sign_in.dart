// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brew_app/constants/constants.dart';
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
  final _signInFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SignIn build()');
    return isLoading
        ? Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator.adaptive()))
        : Scaffold(
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
                  key: _signInFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isNotEmpty && value.contains('@')) {
                            return null;
                          }
                          return 'Please enter a valid email';
                        },
                        controller: _emailController,
                        decoration:
                            textInputDecoration.copyWith(labelText: 'Email'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isNotEmpty && value.length > 6) {
                              return null;
                            }
                            return 'Please enter a valid password';
                          },
                          obscureText: true,
                          controller: _passwordController,
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Password'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_signInFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result =
                                  await authService.signInWithEmailAndPassword(
                                userEmail: _emailController.text,
                                userPassword: _passwordController.text,
                              );
                              if (result == null) {
                                setState(() {
                                  isLoading = false;
                                });
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
