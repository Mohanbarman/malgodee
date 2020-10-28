import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ShoppingApp/styles.dart';
import 'login_form_container.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: DefaultFontColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Title(title: 'Login'),
          LoginFormContainer(),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String title;
  Title({this.title});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            this.title,
            style: LoginScreenTitle,
          ),
        ),
      ),
    );
  }
}
