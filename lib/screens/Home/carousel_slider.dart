import 'package:ShoppingApp/components/offer_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

String _carousel_img_1 = 'assets/images/carousel-item-1.png';
String _carousel_img_2 = 'assets/images/carousel_item_2.png';

class OfferCarousel extends StatefulWidget {
  @override
  _OfferCarouselState createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  int _currentIndex = 0;

  List cardList = [
    {'id': 1, 'imagePath': _carousel_img_1, 'route': '/offer/1'},
    {'id': 2, 'imagePath': _carousel_img_2, 'route': '/offer/1'},
    {'id': 3, 'imagePath': _carousel_img_1, 'route': '/offer/1'},
    {'id': 4, 'imagePath': _carousel_img_2, 'route': '/offer/1'},
    {'id': 5, 'imagePath': _carousel_img_2, 'route': '/offer/1'},
    {'id': 6, 'imagePath': _carousel_img_2, 'route': '/offer/1'},
    {'id': 7, 'imagePath': _carousel_img_2, 'route': '/offer/1'},
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
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOutSine,
              enlargeCenterPage: true,
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
                return GestureDetector(
                  onTap: (() => showDialog(
                        context: context,
                        child: OfferDialog(
                          card['imagePath'],
                        ),
                      )),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.height * 0.21,
                    child: CustomCarouselItem(card['imagePath'], card['route']),
                  ),
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
                  width: _currentIndex == index ? 30.0 : 7,
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
