import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/screens/all_products/local_widgets/product_item.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/not_found_placeholder.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final Stream productsStream;
  final String searchBy;
  final String categoryId;
  final String brandId;

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
          ? FirebaseStorageApi.streamOfCollection(collection: 'products')
          : productsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List filteredSnapshot = searchBy != null
            ? snapshot.data.docs
                .toList()
                .where((e) =>
                    e['name']
                        .toLowerCase()
                        .contains(searchBy.toLowerCase()) ==
                    true)
                .toList()
            : null;

        if (snapshot.data.docs.length < 1)
          return NotFoundPlaceholder(label: 'No product found');

        if (filteredSnapshot != null && filteredSnapshot.length < 1)
          return NotFoundPlaceholder(label: 'No product found');

        return GridView.builder(
          itemCount: searchBy != null
              ? filteredSnapshot.length
              : snapshot.data.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ScreenPadding,
            mainAxisSpacing: ScreenPadding,
          ),
          padding: EdgeInsets.all(ScreenPadding),
          itemBuilder: (context, index) {
            // Product details
            String id = searchBy == null
                ? snapshot.data.docs[index].id
                : filteredSnapshot[index].id;

            String name = searchBy == null
                ? snapshot.data.docs[index]['name']
                : filteredSnapshot[index]['name'];

            String description = searchBy == null
                ? snapshot.data.docs[index]['description']
                : filteredSnapshot[index]['description'];

            List<String> images = searchBy == null
                ? snapshot.data.docs[index]['images'].toList().cast<String>()
                : filteredSnapshot[index]['images'].toList().cast<String>();

            List<String> categories = searchBy == null
                ? snapshot.data.docs[index]['categories']
                    .toList()
                    .cast<String>()
                : filteredSnapshot[index]['categories'].toList().cast<String>();

            String brand = searchBy == null
                ? snapshot.data.docs[index]['brand']
                : filteredSnapshot[index]['brand'];

            return StreamBuilder(
              stream: adminStreamController.authStatusStream,
              builder: (context, authStatusSnapshot) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/productinfo',
                    arguments: ProductModel(
                      images: images,
                      name: name,
                      description: description,
                      id: id,
                      brand: brand,
                      categories: categories,
                    ),
                  ),
                  onLongPress: () {
                    if (adminStreamController.initialData ==
                        UserAuth.isAuthorized) {
                      Navigator.pushNamed(
                        context,
                        '/editproduct',
                        arguments: ProductModel(
                          images: images,
                          name: name,
                          description: description,
                          id: id,
                          brand: brand,
                          categories: categories,
                        ),
                      );
                    }
                  },
                  child: ProductItem(
                    name: name,
                    imageUrl: images.first,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
