import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/models/offer.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('All offers'),
                StreamBuilder(
                  stream: adminStreamController.authStatusStream,
                  initialData: adminStreamController.initialData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1(
                        title: 'Add offer',
                        route: '/addoffer',
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
            padding: EdgeInsets.all(ScreenPadding),
          ),
          Expanded(
            child: CustomGridView2x2(
              onLongPress: ({
                String id,
                String name,
                String image,
                String description,
              }) {
                Navigator.pushNamed(
                  context,
                  '/editoffer',
                  arguments: OfferModel(
                    id: id,
                    name: name,
                    image: image,
                    description: description,
                  ),
                );
              },
              itemsStream: FirebaseStorageApi.streamOfCollection(
                collection: 'offers',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
