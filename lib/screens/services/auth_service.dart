import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_app/models/local_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//! Create User Object based on FirebaseUser
  LocalUser _userFromFirebaseUser(User firebaseUser) {
    return LocalUser(uid: firebaseUser.uid);
  }

  //! Authentication Change User Stream
  Stream<LocalUser?> get userStream {
    return _auth
        .authStateChanges()
        // Maping the firebase user to the localUser
        .map((firebaseUser) => _userFromFirebaseUser(firebaseUser!));
  }

  //!Sign in with email and password
  Future signInWithEmailAndPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print('This is the error ${error.toString()}');
      return null;
    }
  }

  //!Create a new user with email and password
  Future createUserWithEmailAndPassword(
      {required String userEmail, required String userPassword}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print('This is the error ${error.toString()}');
      return null;
    }
  }

//! Signin Anonymously
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (error) {
      print('This is the error ${error.toString()}');
      return null;
    }
  }

  //!Sign out

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('This is the error ${error.toString()}');
      return null;
    }
  }
}



  //!Register with Gmail


  //!Signin with Gmail




  