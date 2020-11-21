import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/models/brand.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/underlined_text.dart';
import '../../widgets/custom_grid.dart';
import '../../styles.dart';

class AllBrands extends StatelessWidget {
  var ref = productFlowBloc.productStreamRouteInfo;

  Stream _streamProductFlow =
      productFlowBloc.productStreamRouteInfo['category'] != null
          ? FirebaseStorageApi.streamOfDocument(
              collection: 'categories',
              id: productFlowBloc.productStreamRouteInfo['category'])
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
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UnderlinedText('All brands'),
                  StreamBuilder(
                    initialData: adminStreamController.initialData,
                    stream: adminStreamController.authStatusStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data == UserAuth.isAuthorized) {
                        return Button1(title: 'Add brand', route: '/addbrand');
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              StreamBuilder(
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
                      collection: 'brands',
                    ),
                    referer: Referer.brand,
                    onTap: (String id) {
                      productFlowBloc.add(context, {'brand': id});
                    },
                    filterByIds:
                        snapshot.hasData ? snapshot.data['brands'] : null,
                    onLongPress: ({
                      String id,
                      String name,
                      String image,
                      String description,
                    }) {
                      Navigator.pushNamed(
                        context,
                        '/editbrand',
                        arguments: BrandModel(
                          id: id,
                          name: name,
                          image: image,
                          description: description,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
