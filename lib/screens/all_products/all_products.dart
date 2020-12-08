import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/screens/all_products/local_widgets/products_grid.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:flutter/material.dart';

class AllProducts extends StatelessWidget {
  Map<String, dynamic> ids = Map.from(productFlowBloc.productStreamRouteInfo);

  final String searchBy;
  AllProducts({this.searchBy});

  @override
  Widget build(BuildContext context) {
    bool _hasPrevId = ids['brand'] != null && ids['category'] != null;
    print(ids);
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
                  UnderlinedText('All products'),
                  StreamBuilder(
                    initialData: adminStreamController.initialData,
                    builder: (context, snapshot) {
                      if (snapshot.data == UserAuth.isAuthorized) {
                        return Button1(
                          title: 'Add product',
                          route: '/addproduct',
                        );
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
                categoryId: _hasPrevId ? ids['category'] : null,
                brandId: _hasPrevId ? ids['brand'] : null,
                searchBy: searchBy,
                productsStream: _hasPrevId
                    ? FirebaseStorageApi.productsFiltered(idMap: ids)
                    : FirebaseStorageApi.streamOfCollection(
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
