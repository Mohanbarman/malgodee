import 'package:ShoppingApp/widgets/offer_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class OfferImageContainer extends StatelessWidget {
  OfferImageContainer({this.fromBytes, this.bytes, this.imageUrl});

  final String imageUrl;
  final fromBytes;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, child: OfferDialog(imageUrl: imageUrl));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: MediaQuery.of(context).size.width / 2 - 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: BackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(OfferBorderRadius),
          ),
        ),
        child: imageUrl == null
            ? Image.memory(
                this.bytes,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
