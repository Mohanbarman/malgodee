import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:icon_shadow/icon_shadow.dart';

class RatingWidget extends StatelessWidget {
  final String _rating;
  RatingWidget(this._rating);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ScreenPadding, top: ScreenPadding),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _rating,
                    style: RatingWidgetTextStyle,
                  ),
                  IconShadowWidget(
                    Icon(Icons.star, color: SecondaryColor),
                    showShadow: true,
                    shadowColor: SecondaryColor,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      color: Neumorphism1,
                      offset: Offset(2, 2)),
                  BoxShadow(
                      blurRadius: 9,
                      color: Neumorphism2,
                      offset: Offset(-1, -1)),
                ]),
          ),
        ],
      ),
    );
  }
}
