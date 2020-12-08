import 'package:ShoppingApp/widgets/not_found_placeholder.dart';
import 'package:ShoppingApp/widgets/offer_image_container.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

class OfferCarousel extends StatefulWidget {
  @override
  _OfferCarouselState createState() => _OfferCarouselState();
}

class _OfferCarouselState extends State<OfferCarousel> {
  int _currentIndex = 0;

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
          StreamBuilder(
            stream: FirebaseStorageApi.streamOfCollection(collection: 'offers'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SizedBox();
              if (snapshot.data.docs.length < 1)
                return Container(
                  height: 300,
                  child: NotFoundPlaceholder(label: 'No offers found'),
                );
              List<Widget> items = snapshot.data.docs
                  .map((e) => OfferImageContainer(imageUrl: e['image']))
                  .toList()
                  .cast<Widget>();
              return Column(children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.20,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOutSine,
                    enlargeCenterPage: false,
                    pageSnapping: true,
                    enableInfiniteScroll: true,
                    viewportFraction: .49,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: items,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    items,
                    (index, url) {
                      return Container(
                        width: _currentIndex == index ? 30.0 : 7,
                        height: 7.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5.0),
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
              ]);
            },
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
