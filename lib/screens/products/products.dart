import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/components/buttons.dart';

String fanImage = 'assets/images/fan-product.png';

List products = [
  {'id': 01, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 02, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 03, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 04, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 05, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 06, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 07, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 08, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
  {'id': 09, 'title': 'havells Stealth', 'rating': 4.9, 'image': fanImage},
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
  final Map prevRouteInfo;

  AllProducts(this.prevRouteInfo) {
    print(prevRouteInfo);
  }

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
                StreamBuilder(
                  stream: adminStreamController.authStatusStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == UserAuth.isAuthorized) {
                      return Button1('Add product', '/addproduct');
                    } else {
                      return SizedBox();
                    }
                  },
                ),
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
  final databaseReference = FirebaseFirestore.instance;
  OfferImageGridItem(this._imagePath, this._title, this._rating);

  Map<String, dynamic> demoProduct = {
    'id': '2',
    'name': 'Example product',
    'description': 'Example product description',
    'highlights':
        'Some example highlights\nAother Highlight\nand some another hightlight'
  };

  void createDemoProduct() async {
    await databaseReference.collection('product').add(demoProduct);
    print('Product created..');
  }

  void retreiveProducts() async {
    await databaseReference
        .collection('product')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) => print(element.data()['name']));
    });
    print('All products fetched');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: retreiveProducts,
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
