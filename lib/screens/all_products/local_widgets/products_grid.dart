import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/screens/all_products/local_widgets/product_item.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/not_found_placeholder.dart';
import 'package:flutter/material.dart';

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
            List<String> categories =
                snapshot.data.docs[index]['categories'].toList().cast<String>();
            String brand = snapshot.data.docs[index]['brand'];

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
              onLongPress: () => Navigator.pushNamed(
                context,
                '/editproduct',
                arguments: ProductModel(
                  name: name,
                  description: description,
                  brand: brand,
                  categories: categories,
                  id: id,
                  images: images,
                ),
              ),
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
