import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/widgets/shimmer_placeholders.dart';
import '../../widgets/underlined_text.dart';
import '../../widgets/buttons.dart';
import '../../widgets/offer_image_container.dart';

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
            stream: FirebaseStorageApi.streamOfCollection(collection: 'offers'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return OfferImagePlaceholder();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  2,
                  (index) {
                    return OfferImageContainer(
                      imageUrl: snapshot.data.docs[index]['image'],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
