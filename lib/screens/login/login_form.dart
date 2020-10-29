import 'dart:io';
import 'package:ShoppingApp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _inputPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 15);
  final _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.white),
  );
  Color _loginBtnColor = SecondaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Text('Username or email', style: LoginFormLabelStyle),
              ],
            ),
            SizedBox(height: ScreenPadding / 2),
            TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
              decoration: InputDecoration(
                contentPadding: _inputPadding,
                hintText: 'yourmail@domain.com',
                hintStyle: InputPlaceholderTextStyle,
                fillColor: Colors.white,
                filled: true,
                border: _inputBorder,
                focusedBorder: _inputBorder,
                enabledBorder: _inputBorder,
                errorBorder: _inputBorder,
                focusedErrorBorder: _inputBorder,
              ),
            ),
            SizedBox(height: ScreenPadding * 2),
            Row(
              children: [
                Text('Password', style: LoginFormLabelStyle),
              ],
            ),
            SizedBox(height: ScreenPadding / 2),
            TextFormField(
              controller: _passwordTextController,
              obscureText: !_showPassword,
              validator: passwordValidator,
              decoration: InputDecoration(
                border: _inputBorder,
                focusedBorder: _inputBorder,
                enabledBorder: _inputBorder,
                errorBorder: _inputBorder,
                focusedErrorBorder: _inputBorder,
                contentPadding: _inputPadding,
                fillColor: Colors.white,
                filled: true,
                suffixIcon: _showPassword == true
                    ? IconButton(
                        icon: Icon(
                          FeatherIcons.eye,
                          color: DefaultFontColor,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          FeatherIcons.eyeOff,
                          color: DefaultFontColor,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
              ),
            ),
            SizedBox(height: ScreenPadding * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  elevation: 20,
                  shadowColor: SecondaryColorDropShadow,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                    onPressed: () async {
                      // setState(() {
                      //   _loginBtnColor = DefaultGreenColor;
                      // });
                      onSubmit(
                        context,
                        _formKey,
                        _emailTextController,
                        _passwordTextController,
                      );
                    },
                    color: _loginBtnColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Login', style: UploadButtonTextStyle),
                        SizedBox(width: ScreenPadding * 2),
                        Icon(
                          FeatherIcons.arrowRight,
                          color: Colors.white,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

onSubmit(context, formKey, emailController, passwordController) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (formKey.currentState.validate()) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AccentColor,
            content: Text('Verifying credentials'),
          ),
        );
        await Firebase.initializeApp();
        Authentication(context).signInWithEmail(
          emailController.text,
          passwordController.text,
        );
      }
    }
  } on SocketException catch (_) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: DefaultRedColor,
        content: Text('Internet not working'),
      ),
    );
  }
}

String emailValidator(String value) {
  if (value.isEmpty) {
    return 'Email can\'t be empty';
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}

String passwordValidator(String value) {
  if (value.isEmpty) {
    return 'Password can\'t be empty';
  }
  return null;
}
