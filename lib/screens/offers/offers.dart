import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/offer_image_container.dart';
import 'package:ShoppingApp/components/offer_dialog.dart';

String _offer_image_1 = 'assets/images/carousel-item-1.png';
String _offer_image_2 = 'assets/images/carousel_item_2.png';

List offers = [
  {'image': _offer_image_1},
  {'image': _offer_image_2},
  {'image': _offer_image_2},
  {'image': _offer_image_1},
  {'image': _offer_image_2},
  {'image': _offer_image_2},
  {'image': _offer_image_1},
  {'image': _offer_image_2},
  {'image': _offer_image_2},
  {'image': _offer_image_1},
  {'image': _offer_image_2},
  {'image': _offer_image_2},
  {'image': _offer_image_1},
  {'image': _offer_image_2},
  {'image': _offer_image_2},
  {'image': _offer_image_1},
  {'image': _offer_image_2},
];

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(2),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: ScreenPadding,
                top: ScreenPadding,
                right: ScreenPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UnderlinedText('All offers'),
                ],
              ),
            ),
            ...offers.map(
              (offer) => Container(
                margin: EdgeInsets.only(
                  left: ScreenPadding,
                  top: ScreenPadding,
                  right: ScreenPadding,
                ),
                child: Column(
                  children: [
                    SizedBox(height: ScreenPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              child: OfferDialog(offer['image']),
                            );
                          },
                          child: StreamBuilder(
                            initialData: adminStreamController.initialData,
                            stream: adminStreamController.authStatusStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == UserAuth.isAuthorized) {
                                return Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      OfferImageContainer(
                                          imagePath: offer['image']),
                                      SizedBox(height: ScreenPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButtonLTR(
                                            icon: Icon(
                                              FeatherIcons.edit2,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                    context, '/addoffer'),
                                            fgColor: SecondaryColor,
                                            shadowColor:
                                                SecondaryColorDropShadow,
                                            label: 'Edit',
                                          ),
                                          DeleteButton1(onPressed: () {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return OfferImageContainer(
                                    imagePath: offer['image']);
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              child: OfferDialog(offer['image']),
                            );
                          },
                          child: StreamBuilder(
                            initialData: adminStreamController.initialData,
                            stream: adminStreamController.authStatusStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == UserAuth.isAuthorized) {
                                return Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      OfferImageContainer(
                                          imagePath: offer['image']),
                                      SizedBox(height: ScreenPadding),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButtonLTR(
                                            icon: Icon(
                                              FeatherIcons.edit2,
                                              color: Colors.white,
                                              size: 15,
                                            ),
                                            onPressed: () =>
                                                Navigator.pushNamed(
                                                    context, '/addoffer'),
                                            fgColor: SecondaryColor,
                                            shadowColor:
                                                SecondaryColorDropShadow,
                                            label: 'Edit',
                                          ),
                                          DeleteButton1(onPressed: () {}),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return OfferImageContainer(
                                  imagePath: offer['image'],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ScreenPadding),
          ],
        ),
      ),
    );
  }
}

class IconButtonLTR extends StatelessWidget {
  final Color fgColor;
  final Function onPressed;
  final Color shadowColor;
  final Icon icon;
  final String label;
  IconButtonLTR(
      {this.fgColor, this.onPressed, this.shadowColor, this.icon, this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(5, 7),
            color: shadowColor,
          ),
        ],
      ),
      child: FlatButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        color: fgColor,
        onPressed: this.onPressed,
        icon: this.icon,
        label: Text('  ' + this.label, style: UploadButtonTextStyle),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
    );
  }
}

class DeleteButton1 extends StatelessWidget {
  final Function onPressed;
  DeleteButton1({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: DefaultRedColor,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(5, 7),
            color: DefaultShadowRedColor,
          ),
        ],
      ),
      child: IconButton(
        onPressed: this.onPressed,
        splashRadius: 30,
        icon: Icon(FeatherIcons.trash, color: Colors.white, size: 18),
      ),
    );
  }
}
