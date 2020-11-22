import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';

Widget NotFoundPlaceholder({String label}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        Icons.warning_rounded,
        color: DefaultRedColor,
        size: 70,
      ),
      Container(height: 5),
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: DefaultRedColor,
        ),
      ),
    ],
  );
}
