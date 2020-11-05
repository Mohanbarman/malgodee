import 'package:ShoppingApp/components/offer_dialog.dart';
import 'package:ShoppingApp/components/offer_image_container.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
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

  List<Widget> snapshotsToWidgets(snapshot) {
    return snapshot.data.docs
        .map(
          (d) => FutureBuilder(
            future: FirebaseStorageApi.futureFromImagePath(d['image']),
            builder: (context, snapshot2) {
              if (snapshot2.hasData) {
                return GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    child: OfferDialog(
                      bytes: snapshot2.data,
                    ),
                  ),
                  child: OfferImageContainer(
                    bytes: snapshot2.data,
                    fromBytes: true,
                  ),
                );
              }
              return OfferImagePlaceholder();
            },
          ),
        )
        .toList()
        .cast<Widget>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      color: BackgroundColor,
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseStorageApi.allOffersStream(limit: 5),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return OfferImagePlaceholder();
              List<Widget> items = snapshotsToWidgets(snapshot);
              return Column(children: [
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
