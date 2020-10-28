import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';
import 'profile_icon.dart';
import 'login_form.dart';

class LoginFormContainer extends StatelessWidget {
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
