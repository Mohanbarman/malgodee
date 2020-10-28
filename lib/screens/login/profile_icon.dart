import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
