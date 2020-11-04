import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../styles.dart';

class RoundedIconContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  String route;
  Function onTap;
  bool viewAllIcon = false;
  Uint8List bytes;

  RoundedIconContainer({
    this.title,
    this.imagePath,
    this.route,
    this.onTap,
    this.viewAllIcon,
    this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: this.viewAllIcon == true
                ? IconButton(
                    icon: Icon(FeatherIcons.grid, color: DefaultFontColor),
                    onPressed: () {
                      print('clicked');
                    },
                  )
                : GestureDetector(
                    onTap: this.onTap,
                    child: Image(
                      image: bytes == null
                          ? AssetImage(this.imagePath)
                          : MemoryImage(bytes),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          ),
          SizedBox(height: 10),
          Text(this.title, style: BodyTextStyle1)
        ],
      ),
    );
  }
}
