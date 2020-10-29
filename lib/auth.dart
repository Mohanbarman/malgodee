import 'package:ShoppingApp/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;
  Authentication(this.context);

  signInWithEmail(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseAuth.instance.currentUser;
      Scaffold.of(context)
          .showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: DefaultGreenColor,
              content: Text('Sign in successfully',
                  style: TextStyle(color: Colors.black)),
            ),
          )
          .closed
          .then((_) => Navigator.pushReplacementNamed(this.context, '/'));
      // print(creds);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text('Email not found'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text('Wrong password'),
          ),
        );
      }
    }
  }

  static isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
