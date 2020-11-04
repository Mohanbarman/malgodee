import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import '../../components/underlined_text.dart';
import '../../components/buttons.dart';
import '../../components/offer_image_container.dart';

String _offerImage1 = 'assets/images/carousel_item_2.png';
String _offerImage2 = 'assets/images/carousel-item-1.png';

class TrendingOffersSection extends StatefulWidget {
  @override
  _TrendingOffersSectionState createState() => _TrendingOffersSectionState();
}

class _TrendingOffersSectionState extends State<TrendingOffersSection> {
  final FirebaseStorageApi storage = FirebaseStorageApi();

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
                    return Button1(
                      title: 'Add offer',
                      onPress: () {
                        FirebaseStorageApi()
                          ..trendingOffersFuture(1).then(
                            (value) => print(value),
                          );
                      },
                    );
                  } else {
                    return Button1(title: 'View all', route: '/offers');
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              2,
              (index) => FutureBuilder(
                future: storage.trendingOffersFuture(index),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return (OfferImageContainer(
                      fromBytes: true,
                      bytes: snapshot.data,
                    ));
                  return OfferImagePlaceholder();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
