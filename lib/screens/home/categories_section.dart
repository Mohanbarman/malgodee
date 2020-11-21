import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/widgets/rounded_icon_container.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';

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
                        title: 'Add category',
                        route: '/addcategory',
                      );
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
              builder: (context, querySnapshot) {
                int itemCount = querySnapshot.hasData
                    ? querySnapshot.data.docs.length + 1
                    : 6;
                return ListView.builder(
                    itemCount: itemCount,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (itemCount - 1 == index) {
                        return Row(
                          children: [
                            SizedBox(width: ScreenPadding),
                            RoundedIconContainer(
                              title: 'All categories',
                              viewAllIcon: true,
                              route: '/allcategories',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/allcategories',
                                  arguments:
                                      productFlowBloc.productStreamRouteInfo,
                                );
                              },
                            ),
                            SizedBox(width: ScreenPadding),
                          ],
                        );
                      }

                      if (!querySnapshot.hasData) return SizedBox();

                      String name =
                          querySnapshot.data.docs.toList()[index]['name'];
                      String image =
                          querySnapshot.data.docs.toList()[index]['image'];
                      String id = querySnapshot.data.docs.toList()[index].id;
                      return Row(
                        children: [
                          SizedBox(width: ScreenPadding),
                          RoundedIconContainer(
                            imageUrl: image,
                            title: name,
                            onTap: () {
                              productFlowBloc.add(context, {'category': id});
                            },
                          ),
                          SizedBox(width: ScreenPadding),
                        ],
                      );
                    });
              },
            ),
          ),
          SizedBox(width: 30),
        ],
      ),
    );
  }
}
