import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: fromBytes == null
          ? Image.asset(
              imagePath,
              fit: BoxFit.cover,
            )
          : Image.memory(this.bytes),
    );
  }
}

class OfferImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.ltr,
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[300],
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: MediaQuery.of(context).size.width / 2 - 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
