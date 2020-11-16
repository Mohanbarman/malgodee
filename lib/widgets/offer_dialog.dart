import 'dart:typed_data';

import 'package:flutter/material.dart';

class OfferDialog extends StatelessWidget {
  String image;
  Uint8List bytes;
  OfferDialog({this.image, this.bytes});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        color: Colors.black45,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: MediaQuery.of(context).size.width - 40,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.blue,
              ),
              child: Image(
                image: bytes == null ? AssetImage(image) : MemoryImage(bytes),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
