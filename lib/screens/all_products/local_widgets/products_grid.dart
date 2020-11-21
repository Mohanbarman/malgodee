import 'package:ShoppingApp/screens/all_products/local_widgets/product_item.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final Stream productsStream;
  final List filterByIds;

  ProductsGrid({this.productsStream, this.filterByIds});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

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

            return ProductItem(
              name: name,
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/shoppingapp-cf7a8.appspot.com/o/026988a0-25ae-11eb-a052-3377cddf074d.jpg?alt=media&token=55b412c8-a58c-43ce-adea-025729e0805d',
            );
          },
        );
      },
    );
  }
}
