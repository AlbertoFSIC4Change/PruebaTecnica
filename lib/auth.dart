import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  //Anonymous Sign in
  Future<String> signInAnon() async {
    UserCredential user = await FirebaseAuth.instance.signInAnonymously();
    return user.user!.uid;
  }

  //Email+Passwd Sign In
  Future<String> signInEmail(String email, String password) async{
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password);
    return user.user!.uid;
  }

  //Email+Passwd Register
  Future<String> registerEmail(String email, String password) async{
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password);
    return user.user!.uid;
  }

  //Sign Out
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  //Current user
  Future<String?> currentUser() async{
    User? user = await FirebaseAuth.instance.currentUser;

    if(user == null) return null;
    else return user.uid;
  }

  Stream<User?> get user{
    return FirebaseAuth.instance.authStateChanges();
  }

}