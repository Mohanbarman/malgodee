import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShoppingApp/flavour.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/components/buttons.dart';

String fanImage = 'assets/images/fan-product.png';

List products = [
  {'id': 1, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 2, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 3, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 4, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 5, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 6, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 7, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 8, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 9, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 10, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 11, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 12, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 13, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 14, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 15, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 16, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 17, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 18, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 19, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 20, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 21, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
];

class AllProducts extends StatelessWidget {
  final Map args;
  AllProducts(this.args);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(0),
      backgroundColor: BackgroundColor,
      body: Container(
        padding:
            EdgeInsets.fromLTRB(ScreenPadding, ScreenPadding, ScreenPadding, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('Products'),
                Provider.of<User>(context) == User.authenticated
                    ? Button1('Add product', '/addproduct')
                    : null
              ],
            ),
            SizedBox(height: ScreenPadding),
            productRow(),
            productRow(),
            productRow(),
            productRow(),
            productRow(),
            productRow(),
          ],
        ),
      ),
    );
  }
}

Column productRow() {
  return (Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OfferImageGridItem(products[0]['image'], products[0]['title'],
              products[0]['rating']),
          OfferImageGridItem(
              products[0]['image'], products[0]['title'], products[0]['rating'])
        ],
      ),
      SizedBox(height: ScreenPadding),
    ],
  ));
}

class OfferImageGridItem extends StatelessWidget {
  final String _imagePath;
  final String _title;
  final double _rating;
  OfferImageGridItem(this._imagePath, this._title, this._rating);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/productinfo',
          arguments: Provider.of<User>(context, listen: false)),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: MediaQuery.of(context).size.width / 2 - 30,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Image(
              image: AssetImage(_imagePath),
              fit: BoxFit.contain,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black26,
                      Colors.white10,
                    ]),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 80,
                height: 35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.star, size: 20, color: Colors.black38),
                    Text(
                      _rating.toString(),
                      style: TextStyle(color: DefaultFontColor),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 50,
                child: Center(
                  child: Text(_title, style: ProductGridItemTitle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
