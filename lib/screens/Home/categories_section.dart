import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/rounded_icon_container.dart';
import 'package:ShoppingApp/components/buttons.dart';
import 'package:ShoppingApp/styles.dart';

class CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText("Categories"),
                StreamBuilder(
                  initialData: adminStreamController.initialData,
                  stream: adminStreamController.authStatusStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1(
                          title: 'Add category', route: '/addcategory');
                    } else if (snapshot.data == UserAuth.unauthorized) {
                      return SizedBox();
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 90.0,
            child: StreamBuilder(
              stream: FirebaseStorageApi.streamOfCollection(
                collection: 'categories',
                limit: 5,
              ),
              builder: (context, snapshot) {
                int itemCount =
                    snapshot.hasData ? snapshot.data.docs.length : 6;
                return ListView.builder(
                  itemCount: itemCount,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (itemCount == ++index) {
                      return Row(
                        children: [
                          SizedBox(width: ScreenPadding),
                          RoundedIconContainer(
                            title: 'All categories',
                            viewAllIcon: true,
                          ),
                          SizedBox(width: ScreenPadding),
                        ],
                      );
                    }
                    if (snapshot.hasData) {
                      String title = snapshot.data.docs.toList()[index]['name'];
                      String imagePath =
                          snapshot.data.docs.toList()[index]['image'];
                      return Row(
                        children: [
                          SizedBox(width: ScreenPadding),
                          FutureBuilder(
                            future: FirebaseStorageApi.futureFromImagePath(
                                imagePath),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return RoundedIconContainer(
                                  title: title,
                                  bytes: snapshot.data,
                                );
                              }
                              return CategoriesImagePlaceholder();
                            },
                          ),
                          SizedBox(width: ScreenPadding),
                        ],
                      );
                    }
                    return CategoriesImagePlaceholder();
                  },
                );
              },
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
