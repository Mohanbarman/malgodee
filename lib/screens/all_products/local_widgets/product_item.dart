import 'package:ShoppingApp/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  ProductItem({this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(OfferBorderRadius),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width - ScreenPadding * 13,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: <Color>[Colors.black87, Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              // color: Colors.blue,
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width - ScreenPadding * 13,
              child: Center(child: Text(name, style: ProductGridItemTitle)),
            ),
          ),
        ],
      ),
    );
  }
}
