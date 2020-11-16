import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/models/offer.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/services/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/buttons.dart';

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(0),
      backgroundColor: BackgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenPadding,
          ScreenPadding,
          ScreenPadding,
          0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('Products'),
                StreamBuilder(
                  initialData: adminStreamController.initialData,
                  stream: adminStreamController.authStatusStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1(
                          title: 'Add product', route: '/addproduct');
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseStorageApi.streamOfCollection(
                  collection: 'products',
                ),
                builder: (context, snapshot) {
                  int productsLength =
                      snapshot.hasData ? snapshot.data.docs.length : 10;
                  return GridView.builder(
                    itemCount: productsLength,
                    shrinkWrap: true,
                    cacheExtent: 100,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      if (!snapshot.hasData) return SizedBox();
                      ProductModel productModel = ProductModel(
                        id: snapshot.data.docs[index].id,
                        brand: snapshot.data.docs[index]['brand'],
                        categories: snapshot.data.docs[index]['categories']
                            .cast<String>(),
                        description: snapshot.data.docs[index]['description'],
                        images:
                            snapshot.data.docs[index]['images'].cast<String>(),
                        name: snapshot.data.docs[index]['name'],
                      );
                      return GestureDetector(
                        onLongPress: () {
                          print('Long pressed');
                          Navigator.pushNamed(
                            context,
                            '/editproduct',
                            arguments: productModel,
                          );
                        },
                        child: ProductGridItem(
                          title: productModel.name,
                          image: LocalStorage.loadData(
                            model: OfferModel(
                              id: productModel.id,
                              image: productModel.images[0],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  String title;
  Future image;
  ProductGridItem({this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 30,
      height: MediaQuery.of(context).size.width / 2 - 30,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: MediaQuery.of(context).size.width / 2 - 20,
            child: FutureBuilder(
              future: image,
              builder: (context, imageSnapshot) {
                print(imageSnapshot.hasData);
                if (!imageSnapshot.hasData) return SizedBox();
                return Image(
                  fit: BoxFit.cover,
                  image: MemoryImage(imageSnapshot.data),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 60,
              height: 50,
              child: Center(
                child: Text(title, style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
