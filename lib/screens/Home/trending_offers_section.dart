import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
                      onPress: () {},
                    );
                  } else {
                    return Button1(title: 'View all', route: '/alloffers');
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, snapshot) {
              print(snapshot);
              return OfferImagePlaceholder();
            },
          )
          // FutureBuilder(
          //   future: storage.trendingOffersFuture(1),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData)
          //       return (OfferImageContainer(
          //         fromBytes: true,
          //         bytes: snapshot.data,
          //       ));
          //     return OfferImagePlaceholder();
          //   },
          // ),
          // FutureBuilder(
          //   future: storage.trendingOffersFuture(2),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData)
          //       return (OfferImageContainer(
          //         fromBytes: true,
          //         bytes: snapshot.data,
          //       ));
          //     return OfferImagePlaceholder();
          //   },
          // ),
        ],
      ),
    );
  }
}
