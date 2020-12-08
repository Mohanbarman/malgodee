import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'dart:typed_data';
import '../styles.dart';

class RoundedIconContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  final String imageUrl;
  final String route;
  final Function onTap;
  final bool viewAllIcon;
  final Uint8List bytes;
  final Function onLongPress;
  final double padding;

  RoundedIconContainer({
    this.title,
    this.imagePath,
    this.route,
    this.onTap,
    this.viewAllIcon,
    this.bytes,
    this.onLongPress,
    this.imageUrl,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(padding ?? 0),
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
                  ? GestureDetector(
                      onTap: onTap ?? () {},
                      child: Image(
                        fit: BoxFit.fill,
                        image: bytes == null
                            ? AssetImage(imagePath)
                            : MemoryImage(bytes),
                      ),
                    )
                  : GestureDetector(
                      onLongPress: onLongPress ?? () {},
                      onTap: () => onTap() ?? () {},
                      child: CachedNetworkImage(
                        placeholder: (context, str) => Container(
                          color: Colors.white,
                          height: 60,
                          width: 60,
                          child: Center(
                            child: Text(
                              'No image',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[850],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
        SizedBox(height: 10),
        Text(
          this.title.length > 18
              ? '${this.title.substring(0, 17)}...'
              : this.title,
          style: BodyTextStyle1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
