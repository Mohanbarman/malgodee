import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/underlined_text.dart';
import '../../widgets/custom_grid.dart';
import '../../styles.dart';

class AllCategories extends StatelessWidget {
  Stream _streamProductFlow =
      productFlowBloc.productStreamRouteInfo['brand'] != null
          ? FirebaseStorageApi.streamOfDocument(
              collection: 'brands',
              id: productFlowBloc.productStreamRouteInfo['brand'])
          : null;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        productFlowBloc.clear();
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CustomBottomNavigationBar(null),
        backgroundColor: BackgroundColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(
            ScreenPadding,
            ScreenPadding,
            ScreenPadding,
            0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UnderlinedText('All categories'),
                  StreamBuilder(
                    initialData: adminStreamController.initialData,
                    stream: adminStreamController.authStatusStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data == UserAuth.isAuthorized) {
                        return Button1(
                            title: 'Add category', route: '/addcategory');
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Expanded(
                child: StreamBuilder(
                    stream: _streamProductFlow,
                    builder: (context, snapshot) {
                      if (_streamProductFlow != null && !snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return CustomGridView4x4(
                        itemsStream: FirebaseStorageApi.streamOfCollection(
                          collection: 'categories',
                        ),
                        referer: Referer.category,
                        onTap: (id) {
                          productFlowBloc.add(context, {'category': id});
                        },
                        filterByIds: snapshot.hasData
                            ? snapshot.data['categories']
                            : null,
                        onLongPress: ({
                          String id,
                          String name,
                          String image,
                          String description,
                          List correspondingElements,
                        }) {
                          Navigator.pushNamed(
                            context,
                            '/editcategory',
                            arguments: CategoryModel(
                              id: id,
                              name: name,
                              image: image,
                              brands: correspondingElements,
                              description: description,
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
