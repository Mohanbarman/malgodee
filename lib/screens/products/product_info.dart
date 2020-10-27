import 'package:ShoppingApp/components/app_bar.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'product_highlights_section.dart';
import 'rating_widget.dart';
import '../../styles.dart';
import '../../components/bottom_navigation_bar.dart';

String _carousel_img_1 = 'assets/images/fan-product.png';

List product = [
  {
    'id': 1,
    'title':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam',
    'rating': '4.9',
    'highlights': [
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
      'Lorem ipsum dolor sit amet',
    ],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Porttitor egestas rhoncus neque fermentum nibh bibendum et gravida mollis. Amet, dolor pulvinar cras mauris, justo aliquam sit laoreet. Habitant elit praesent ut libero Porttitor egestas rhoncus neque fermentum nibh bibendum et gravida mollis. Amet, dolor pulvinar cras mauris, justo aliquam sit laoreet. Habitant elit praesent ut libero, ',
  },
];

class ProductInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: Container(
        child: ListView(
          children: [
            ProductInfoCarousel(),
            SizedBox(height: CarouselGapBottom),
            ProductTitle(),
            RatingWidget(product[0]['rating']),
            SizedBox(height: SectionsGap),
            ProductHighlightsSection(product[0]['highlights']),
            SizedBox(height: SectionsGap),
            ProductDescriptionSection(product[0]['description']),
            SizedBox(height: ScreenPadding),
          ],
        ),
      ),
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
          Row(children: [Text('Description', style: HightlightsTitleStyle)]),
          SizedBox(height: ScreenPadding),
          Text(_description, style: HighlightBodyTextStyle),
        ],
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ScreenPadding),
      child: Container(
        child: Text(product[0]['title'], style: ProductInfoTitle),
      ),
    );
  }
}

class ProductInfoCarousel extends StatefulWidget {
  @override
  _ProductInfoCarouselState createState() => _ProductInfoCarouselState();
}

class _ProductInfoCarouselState extends State<ProductInfoCarousel> {
  int _currentIndex = 0;

  List<Widget> cardList = <Widget>[
    CustomCarouselItem(_carousel_img_1, '/productinfo'),
    CustomCarouselItem(_carousel_img_1, '/productinfo'),
    CustomCarouselItem(_carousel_img_1, '/productinfo'),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

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
            items: cardList.map((card) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: card,
                );
              });
            }).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(
              cardList,
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
  final String _route;
  CustomCarouselItem(this._image, this._route);
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Image.asset(
        _image,
        fit: BoxFit.fill,
      ),
    );
  }
}
