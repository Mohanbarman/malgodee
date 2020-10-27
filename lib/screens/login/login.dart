import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/components/input_custom_decoration.dart';

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
          LoginFormBg(),
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

class LoginFormBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: BackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              color: LightBoxShadow,
              blurRadius: 50,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(70),
            topRight: Radius.circular(70),
          ),
        ),
        child: Column(
          children: [
            ProfileIcon(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Row(
            children: [
              Text('Username or email', style: LoginFormLabelStyle),
            ],
          ),
          SizedBox(height: ScreenPadding),
          inputCustomDeocration(
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'yourmail@domain.com',
                hintStyle: InputPlaceholderTextStyle,
              ),
            ),
          ),
          SizedBox(height: ScreenPadding * 2),
          Row(
            children: [
              Text('Password', style: LoginFormLabelStyle),
            ],
          ),
          SizedBox(height: ScreenPadding),
          inputCustomDeocration(
            TextField(
              obscureText: !_showPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: _showPassword == true
                    ? IconButton(
                        icon: Icon(FeatherIcons.eye, color: DefaultFontColor),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      )
                    : IconButton(
                        icon:
                            Icon(FeatherIcons.eyeOff, color: DefaultFontColor),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
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
                  onPressed: () {},
                  color: SecondaryColor,
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
    );
  }
}

class ProfileIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: -50,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AccentColor,
                boxShadow: [
                  BoxShadow(
                    color: AccentColorShadow,
                    blurRadius: 10,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(
                FeatherIcons.user,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
