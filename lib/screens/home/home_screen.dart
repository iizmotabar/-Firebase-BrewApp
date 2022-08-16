import 'package:brew_app/screens/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              authService.signout();
              Navigator.popAndPushNamed(context, '/authenticate');
            },
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Brew App',
        ),
      ),
    );
  }
}
