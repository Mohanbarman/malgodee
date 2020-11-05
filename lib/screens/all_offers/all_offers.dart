import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/offer_dialog.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';

class Offers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: UnderlinedText('All offers'),
            padding: EdgeInsets.only(
              left: ScreenPadding,
              bottom: ScreenPadding,
              top: ScreenPadding,
            ),
          ),
          StreamBuilder(
            stream: FirebaseStorageApi.allOffersStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return OfferImagePlaceholder();
              int offersLength = snapshot.data.docs.length;
              return Expanded(
                child: GridView.builder(
                  itemCount: offersLength,
                  padding: EdgeInsets.all(10),
                  // shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: FirebaseStorageApi.regularOffersFuture(index),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              child: OfferDialog(
                                bytes: snapshot.data,
                              ),
                            ),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.width / 2 - 30,
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: BackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(OfferBorderRadius),
                              ),
                              margin: index == 0 || index == 1
                                  ? EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10)
                                  : EdgeInsets.all(10),
                              child: Image.memory(
                                snapshot.data,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: index == 0 || index == 1
                              ? EdgeInsets.only(left: 10, right: 10, bottom: 10)
                              : EdgeInsets.all(10),
                          child: OfferImagePlaceholder(),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
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