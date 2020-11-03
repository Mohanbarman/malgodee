import 'package:flutter/material.dart';
import '../styles.dart';

class Button1 extends StatelessWidget {
  final String title;
  final String route;
  final Function onPress;
  Button1({this.title, this.route, this.onPress});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: route != null
          ? () => Navigator.pushNamed(
                context,
                route,
              )
          : onPress,
      child: Text(
        title,
        style: Button1TextStyle,
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}

class HighlightedShadowButton extends StatelessWidget {
  final String title;
  final Color fgColor;
  final Color shadowColor;
  final Function onPressed;

  HighlightedShadowButton(
      {this.title, this.fgColor, this.shadowColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(40),
        // color: fgColor,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(5, 7),
            blurRadius: 20,
          ),
        ],
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        color: fgColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(this.title, style: UploadButtonTextStyle),
        onPressed: onPressed,
      ),
    );
  }
}
