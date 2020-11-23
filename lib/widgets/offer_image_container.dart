import 'package:ShoppingApp/widgets/offer_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class OfferImageContainer extends StatelessWidget {
  OfferImageContainer({
    this.imageUrl,
    this.onLongPress,
  });

  final String imageUrl;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress ?? () {},
      onTap: () {
        showDialog(context: context, child: OfferDialog(imageUrl: imageUrl));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: MediaQuery.of(context).size.width / 2 - 30,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: BackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(OfferBorderRadius),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
