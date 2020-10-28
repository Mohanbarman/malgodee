import 'package:ShoppingApp/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShoppingApp/flavour.dart';
import '../../components/underlined_text.dart';
import '../../components/buttons.dart';
import '../../components/offer_image_container.dart';

String _offerImage1 = 'assets/images/carousel_item_2.png';
String _offerImage2 = 'assets/images/carousel-item-1.png';

class TrendingOffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnderlinedText('Trending offers'),
              Authentication.isAuthenticated()
                  ? Button1('Add offer', '/addoffer')
                  : Button1('View all', '/offers')
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OfferImageContainer(_offerImage1),
              OfferImageContainer(_offerImage2),
            ],
          )
        ],
      ),
    );
  }
}
