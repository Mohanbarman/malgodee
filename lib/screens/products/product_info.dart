import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/widgets/offer_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';
import '../../widgets/bottom_navigation_bar.dart';

class ProductInfo extends StatelessWidget {
  ProductModel productModel;
  ProductInfo({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: Container(
        child: ListView(
          children: [
            ProductInfoCarousel(imageUrls: productModel.images),
            SizedBox(height: CarouselGapBottom),
            ProductTitle(title: productModel.name),
            ProductPrice(price: productModel.price),
            SizedBox(height: ScreenPadding),
            ProductDescriptionSection(productModel.description),
            SizedBox(height: ScreenPadding),
          ],
        ),
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  final double price;
  ProductPrice({this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
      child: Text('MOP : ${price == null ? '--' : price} ₹',
          style: ProductInfoTitle),
    );
  }
}

class ProductDescriptionSection extends StatelessWidget {
  final String _description;
  ProductDescriptionSection(this._description);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
      child: Column(
        children: [
          Row(children: [Text('Description : ', style: HightlightsTitleStyle)]),
          SizedBox(height: ScreenPadding),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              _description,
              style: HighlightBodyTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String title;
  ProductTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ScreenPadding),
      child: Container(
        child: Text(title, style: ProductInfoTitle),
      ),
    );
  }
}

class ProductInfoCarousel extends StatefulWidget {
  List<String> imageUrls;
  ProductInfoCarousel({this.imageUrls});
  @override
  _ProductInfoCarouselState createState() => _ProductInfoCarouselState(
        imageUrls: this.imageUrls,
      );
}

class _ProductInfoCarouselState extends State<ProductInfoCarousel> {
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> imageUrls;
  _ProductInfoCarouselState({this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      color: BackgroundColor,
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.20,
              // enlargeCenterPage: true,
              pageSnapping: true,
              enableInfiniteScroll: true,
              viewportFraction: .5,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageUrls.map((e) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: CustomCarouselItem(e),
                );
              });
            }).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              imageUrls,
              (index, url) {
                return Container(
                  width: _currentIndex == index ? 30.0 : 13,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AccentColor
                        : Color(0xff7B869B),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CustomCarouselItem extends StatelessWidget {
  final String _image;
  CustomCarouselItem(this._image);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, child: OfferDialog(imageUrl: _image));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: _image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Center(child: Text(error)),
        ),
      ),
    );
  }
}
