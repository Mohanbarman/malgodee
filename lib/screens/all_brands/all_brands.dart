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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CustomGridView4x4(
              itemsStream: FirebaseStorageApi.streamOfCollection(
                collection: 'brands',
              ),
              referer: 'brand',
              onTap: () {
                if (productFlowBloc.productStreamRouteInfo['category'] !=
                    null) {
                  Navigator.pushNamed(
                    context,
                    '/allproducts',
                    arguments: productFlowBloc.productStreamRouteInfo,
                  );
                }
              },
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
            ),
          ],
        ),
      ),
    );
  }
}
