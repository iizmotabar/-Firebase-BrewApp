import 'package:brew_app/screens/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_app/models/local_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//! Create User Object based on FirebaseUser
  LocalUser _userFromFirebaseUser(User firebaseUser) {
    // Simply mapping the firebase user to a local user model
    return LocalUser(uid: firebaseUser.uid);
  }

  //! Authentication Change User Stream
  Stream<LocalUser?> get userStream {
    // Checking the user stream for authentication changes
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
      // Getting the firebase user back from the result
      User? firebaseUser = result.user;
      // Mapping the firebase user to the localUser
      return _userFromFirebaseUser(firebaseUser!);
    } catch (error) {
    
      return null;
    }
  }

  //!Create a new user with email and password
  Future createUserWithEmailAndPassword(
      {required String userEmail,
      required String userPassword,
      required String userName}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      // User returned from firebase after creating user
      User? firebaseUser = result.user;
      // Create a new user document for the user with the uid for firestore
      await FirestoreService(uid: firebaseUser!.uid)
          .updateUserData('0', userName, 100);
      //  Mapping the firebase user to the localUser
      return _userFromFirebaseUser(firebaseUser);
    } catch (error) {

      return null;
    }
  }

//! Signin Anonymously
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      // User returned from firebase after creating user
      User? firebaseUser = result.user;
      // Mapping the firebase user to the localUser
      return _userFromFirebaseUser(firebaseUser!);
    } catch (error) {
    
      return null;
    }
  }

  //!Sign out

  Future signout() async {
    try {
      // Sign out of firebase by setting the firebase user to null
      return await _auth.signOut();
    } catch (error) {
      print('This is the error ${error.toString()}');
      return null;
    }
  }
}



  //!Register with Gmail


  //!Signin with Gmail




  