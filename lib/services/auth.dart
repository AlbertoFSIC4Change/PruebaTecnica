import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final _firebaseAuth = FirebaseAuth.instance;

  //Anonymous Sign in
  Future<String?> signInAnon() async {
    UserCredential userCred = await _firebaseAuth.signInAnonymously();
    return userCred.user!.uid;
  }

  //Email+Passwd Sign In
  Future<String> signInEmail(String email, String password) async{
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password);
    return user.user!.uid;
  }

  //Email+Passwd Register
  Future<String> registerEmail(String email, String password) async{
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password);
    return user.user!.uid;
  }

  //Sign Out
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  //Current user
  Future<String?> currentUser() async{
    User? user = await _firebaseAuth.currentUser;

    if(user == null) return null;
    else return user.uid;
  }

  Stream<User?> get user{
    return _firebaseAuth.authStateChanges();
  }

}