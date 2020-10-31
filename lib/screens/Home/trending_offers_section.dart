import 'package:ShoppingApp/auth.dart';
import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:flutter/material.dart';
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
              StreamBuilder(
                initialData: adminStreamController.initialData,
                stream: adminStreamController.authStatusStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == UserAuth.isAuthorized) {
                    return Button1('Add offer', '/addoffer');
                  } else {
                    return SizedBox();
                  }
                },
              ),
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
