import 'package:flutter/material.dart';
import '../styles.dart';

class Button1 extends StatelessWidget {
  final String _title;
  final String _route;
  Button1(this._title, this._route);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, _route);
      },
      child: Text(
        _title,
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
