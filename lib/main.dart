import 'package:brew_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/local_user.dart';
import 'screens/authenticate/authenticate.dart';
import 'screens/authenticate/register_user.dart';
import 'screens/authenticate/sign_in.dart';
import 'screens/services/auth_service.dart';
import 'screens/wrapper.dart';

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
    return StreamProvider<LocalUser?>.value(
      initialData: null,
      catchError: (context, error) => null,
      value: AuthService().userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Brew App',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/authenticate': (context) => const Authenticate(),
          '/home': (context) => HomeScreen(),
          '/signin': (context) => SignIn(
                toggleView: () {},
              ),
          '/register': (context) => RegisterUser(
                toggleView: () {},
              ),
        },
      ),
    );
  }
}
