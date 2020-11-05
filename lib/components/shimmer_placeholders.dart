import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';

class OfferImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return defaultShimmer(
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: MediaQuery.of(context).size.width / 2 - 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(OfferBorderRadius),
          ),
        ),
      ),
    );
  }
}

class CategoriesImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultShimmer(
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: BackgroundColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        SizedBox(height: 10),
        defaultShimmer(
          child: Container(
            height: 10,
            width: 50,
            decoration: BoxDecoration(
              color: BackgroundColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )
      ],
    );
  }
}

Widget defaultShimmer({Widget child}) {
  return Shimmer.fromColors(
    child: child,
    direction: ShimmerDirection.ltr,
    baseColor: Colors.grey[200],
    highlightColor: Colors.grey[300],
  );
}
