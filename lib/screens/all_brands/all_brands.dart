import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../components/app_bar.dart';
import '../../components/bottom_navigation_bar.dart';
import '../../components/underlined_text.dart';
import '../../components/custom_grid.dart';

class AllBrands extends StatelessWidget {
  final Map args;
  AllBrands(this.args);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      backgroundColor: BackgroundColor,
      body: Container(
        padding:
            EdgeInsets.fromLTRB(ScreenPadding, ScreenPadding, ScreenPadding, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('All brands'),
                StreamBuilder(
                  stream: adminStreamController.authStatusStream,
                  initialData: adminStreamController.initialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == UserAuth.isAuthorized) {
                      return Button1(title: 'Add brand', route: '/addbrand');
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            CustomGridViewX4(
              itemsStream: FirebaseStorageApi.streamOfCollection(
                collection: 'brands',
              ),
              onTap: (String id) {
                productFlowBloc.productSink.add({'brand': id});
                if (productFlowBloc.productStreamRouteInfo['category'] !=
                    null) {
                  Navigator.pushNamed(
                    context,
                    '/products',
                    arguments: productFlowBloc.productStreamRouteInfo,
                  );
                }
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
