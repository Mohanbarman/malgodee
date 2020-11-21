import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/screens/all_products/local_widgets/products_grid.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  final ProductModel model;
  AllProducts({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(ScreenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UnderlinedText(model == null ? 'All products' : 'Products'),
                  StreamBuilder(
                    initialData: adminStreamController.initialData,
                    builder: (context, snapshot) {
                      if (snapshot.data == UserAuth.isAuthorized) {
                        return Button1(title: 'Add product', onPress: () {});
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ProductsGrid(
                productsStream: FirebaseStorageApi.streamOfCollection(
                  collection: 'products',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
