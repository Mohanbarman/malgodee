import 'package:flutter/material.dart';

class OfferImageContainer extends StatelessWidget {
  final String _imagePath;
  OfferImageContainer(this._imagePath);

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
      child: Image.asset(
        _imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
