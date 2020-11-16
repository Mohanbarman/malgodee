import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/widgets/shimmer_placeholders.dart';
import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/widgets/rounded_icon_container.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/services/localstorage.dart';
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
              builder: (context, querySnapshot) {
                int itemCount =
                    querySnapshot.hasData ? querySnapshot.data.docs.length : 6;
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
                    if (querySnapshot.hasData) {
                      String name =
                          querySnapshot.data.docs.toList()[index]['name'];
                      String imagePath =
                          querySnapshot.data.docs.toList()[index]['image'];
                      String id = querySnapshot.data.docs.toList()[index].id;
                      return Row(
                        children: [
                          SizedBox(width: ScreenPadding),
                          FutureBuilder(
                            future: LocalStorage.loadData(
                              model: CategoryModel(
                                name: name,
                                image: imagePath,
                                id: id,
                              ),
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return RoundedIconContainer(
                                  title: name,
                                  bytes: snapshot.data,
                                  onTap: () {
                                    productFlowBloc.productSink.add(
                                      {
                                        'category':
                                            querySnapshot.data.docs[index].id
                                      },
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      '/allbrands',
                                      arguments: productFlowBloc
                                          .productStreamRouteInfo,
                                    );
                                  },
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
