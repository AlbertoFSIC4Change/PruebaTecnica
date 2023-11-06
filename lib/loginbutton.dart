import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba_tecnica/auth.dart';
import 'loginpage.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  final Auth _auth = Auth();

  void signOut() {
    setState(() {
      _auth.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if(user == null){
      return FloatingActionButton.small(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);},
          child: Icon(Icons.account_circle_rounded));
    } else {
      return FloatingActionButton.small(
          onPressed: () {signOut();},
          child: Icon(Icons.output),);
    }
  }
}

