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
          ElevatedButton.icon(
              onPressed: () async {
                await authService.signout();
              },
              icon: const Icon(Icons.person),
              label: const Text('SignOut')),
        ],
        centerTitle: true,
        title: const Text(
          'Brew App',
        ),
      ),
    );
  }
}
