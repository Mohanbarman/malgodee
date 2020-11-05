import 'dart:typed_data';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';

class OfferImageContainer extends StatelessWidget {
  OfferImageContainer({this.imagePath, this.fromBytes, this.bytes});

  final String imagePath;
  final fromBytes;
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      height: MediaQuery.of(context).size.width / 2 - 30,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: BackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(OfferBorderRadius),
        ),
      ),
      child: fromBytes == null
          ? Image.asset(
              imagePath,
              fit: BoxFit.cover,
            )
          : Image.memory(
              this.bytes,
              fit: BoxFit.cover,
            ),
    );
  }
}
