// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brew_app/constants/constants.dart';
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
    final registerFormKey = GlobalKey<FormState>();

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    bool isLoading = false;

    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      nameController.dispose();
      super.dispose();
    }

    return isLoading == true
        ? Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Scaffold(
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
                  key: registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Name is required' : null,
                        controller: nameController,
                        decoration: textInputDecoration.copyWith(
                          labelText: 'Name',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isNotEmpty && value.contains('@')) {
                              return null;
                            }
                            return 'Please enter a valid email address';
                          },
                          controller: emailController,
                          decoration: textInputDecoration.copyWith(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isNotEmpty && value.length > 6) {
                              return null;
                            }
                            return 'Password must be at least 6 characters';
                          },
                          obscureText: true,
                          controller: passwordController,
                          decoration: textInputDecoration.copyWith(
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (registerFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result = await authService
                                  .createUserWithEmailAndPassword(
                                userEmail: emailController.text,
                                userPassword: passwordController.text,
                              );
                              if (result == null) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                            const SnackBar(content: Text('SignUp Successful!'));
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
