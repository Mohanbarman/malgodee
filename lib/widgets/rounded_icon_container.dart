import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'dart:typed_data';
import '../styles.dart';
import 'dart:io';

class RoundedIconContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  final String imageUrl;
  String route;
  Function onTap;
  bool viewAllIcon = false;
  Uint8List bytes;
  Function onLongPress;

  RoundedIconContainer({
    this.title,
    this.imagePath,
    this.route,
    this.onTap,
    this.viewAllIcon,
    this.bytes,
    this.onLongPress,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: this.viewAllIcon == true
              ? IconButton(
                  icon: Icon(FeatherIcons.grid, color: DefaultFontColor),
                  onPressed: () {
                    if (route != null) Navigator.pushNamed(context, route);
                    if (this.onTap != null) onTap();
                  },
                )
              : imageUrl == null
                  ? Image(
                      fit: BoxFit.fill,
                      image: bytes == null
                          ? FileImage(File(this.imagePath))
                          : MemoryImage(bytes),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                    ),
        ),
        SizedBox(height: 10),
        Text(this.title, style: BodyTextStyle1)
      ],
    );
  }
}
