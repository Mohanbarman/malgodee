import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';

Widget inputCustomDeocration(Widget child) {
  return Container(
    padding: EdgeInsets.only(left: ScreenPadding, right: ScreenPadding / 2),
    decoration: BoxDecoration(
      color: LoginInputBgColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: LightBoxShadow,
          blurRadius: 10,
          offset: Offset(0, 0),
        ),
      ],
    ),
    child: child,
  );
}
