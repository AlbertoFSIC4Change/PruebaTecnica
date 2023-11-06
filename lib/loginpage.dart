import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tecnica/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  final Auth _auth = Auth();

  void emailLogIn() async{
    final form = formKey.currentState;
    if(form!.validate()){
      try{
        form.save();
        String userid = await _auth.signInEmail(_email!, _password!);
        print('console: Logged in as $userid');

        Navigator.pop(context);
      } catch(e){

      }
    } else {
      print('console: Form is invalid');
    }
  }

  void anonymousLogin() async{
    String user = await _auth.signInAnon();
    (user != null) ? print('console: Logged in as $user') : print('console: Error logging in');
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Field cannot be Empty' : null,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) => value!.isEmpty ? 'Field cannot be Empty' : null,
                onSaved: (value) => _password = value!,
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: emailLogIn,
                  child: Text('Login')),
              ElevatedButton(
                  onPressed: anonymousLogin,
                  child: Text('Sign in Anonymously')),
            ],
          ),
        )
      )
    );
  }
}
