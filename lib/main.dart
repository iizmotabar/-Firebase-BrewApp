import 'package:brew_app/screens/home/home_screen.dart';
import 'package:brew_app/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/authenticate/authenticate.dart';
import 'screens/authenticate/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/wrapper',
      routes: {
        '/': (context) => const HomeScreen(),
        '/authenticate': (context) => const Authenticate(),
        '/wrapper': (context) => const Wrapper(),
        '/signin': (context) => const SignIn(),
      },
    );
  }
}
