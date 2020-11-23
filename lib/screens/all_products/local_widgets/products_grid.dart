import 'package:ShoppingApp/screens/all_products/local_widgets/product_item.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/not_found_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

class ProductsGrid extends StatelessWidget {
  final Stream productsStream;
  final String categoryId;
  final String brandId;
  final String searchBy;

  ProductsGrid({
    this.productsStream,
    this.categoryId,
    this.brandId,
    this.searchBy,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: searchBy != null
          ? FirebaseStorageApi.streamOfCollectionSearch(
              searchQuery: searchBy,
              collection: 'products',
            )
          : productsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        if (snapshot.data.docs.length < 1)
          return NotFoundPlaceholder(label: 'No product found');

        return GridView.builder(
          itemCount: snapshot.data.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ScreenPadding,
            mainAxisSpacing: ScreenPadding,
          ),
          padding: EdgeInsets.all(ScreenPadding),
          itemBuilder: (context, index) {
            // Product details
            String id = snapshot.data.docs[index].id;
            String name = snapshot.data.docs[index]['name'];
            String description = snapshot.data.docs[index]['description'];
            List<String> images =
                snapshot.data.docs[index]['images'].toList().cast<String>();

            return GestureDetector(
              onTap: () => print('name: $name'),
              onLongPress: () => print('name (longPress): $name'),
              child: ProductItem(
                name: name,
                imageUrl: images.first,
              ),
            );
          },
        );
      },
    );
  }
}
