import 'package:ShoppingApp/bloc/login_button_state.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bloc/admin_features.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  final BuildContext context;
  Authentication(this.context);

  signInWithEmail(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Scaffold.of(context)
          .showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
              backgroundColor: DefaultGreenColor,
              content: Text('Sign in successfully',
                  style: TextStyle(color: Colors.black)),
            ),
          )
          .closed
          .then((_) {
        loginButtonState.loginBtnSink.add(ButtonState.isActive);
        print('THis ran');
        Navigator.pushReplacementNamed(context, '/');
      });
      adminStreamController.authStatusSink.add(UserAuth.isAuthorized);
      // .then((_) => Navigator.pushReplacementNamed(this.context, '/'));
    } catch (e) {
      if (e.code == 'user-not-found') {
        loginButtonState.loginBtnSink.add(ButtonState.isActive);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text('Email not found'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        loginButtonState.loginBtnSink.add(ButtonState.isActive);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text('Wrong password'),
          ),
        );
      } else if (e.code == 'too-many-requests') {
        print(e);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text(
                'We have blocked all requests from this device due to unusual activity. Try again later'),
          ),
        );
        loginButtonState.loginBtnSink.add(ButtonState.isActive);
      } else {
        loginButtonState.loginBtnSink.add(ButtonState.isActive);
        print(e);
      }
    }
  }

  static isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
