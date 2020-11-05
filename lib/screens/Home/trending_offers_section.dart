import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/components/offer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';
import '../../components/underlined_text.dart';
import '../../components/buttons.dart';
import '../../components/offer_image_container.dart';

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
                    return Button1(
                      title: 'Add offer',
                      route: '/addoffer',
                    );
                  } else {
                    return Button1(title: 'View all', route: '/offers');
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          StreamBuilder(
            stream: FirebaseStorageApi.trendingOffersStream(),
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  2,
                  (index) => FutureBuilder(
                    future: FirebaseStorageApi().trendingOffersFuture(index),
                    builder: (context, snapshot) {
                      // print(snapshot.data);
                      if (snapshot.hasData)
                        return GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            child: OfferDialog(
                              bytes: snapshot.data,
                            ),
                          ),
                          child: OfferImageContainer(
                            fromBytes: true,
                            bytes: snapshot.data,
                          ),
                        );
                      return OfferImagePlaceholder();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
