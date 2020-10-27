import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/app_bar.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/components/buttons.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: ListView(
        shrinkWrap: true,
        children: [
          Title(),
          // SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(ScreenPadding),
            child: Text('Product Image', style: AddFieldLabelStyle),
          ),
          ImageRow(),
          SizedBox(height: 30),
          UploadDetailsForm(),
        ],
      ),
    );
  }
}

class UploadDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding * 1.5),
      child: Column(
        children: [
          Row(children: [Text('Brand Title', style: AddFieldLabelStyle)]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(children: [Text('Brand Description', style: AddFieldLabelStyle)]),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              maxLines: 8,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HighlightedShadowButton(
                title: 'Save',
                fgColor: DefaultGreenColor,
                shadowColor: DefaultShadowGreenColor,
                onPressed: () {},
              ),
              HighlightedShadowButton(
                title: 'Cancel',
                fgColor: DefaultRedColor,
                shadowColor: DefaultShadowRedColor,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(ScreenPadding),
        child: UnderlinedText('Add product').noUnderline(),
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          SizedBox(width: ScreenPadding),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              width: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      FeatherIcons.upload,
                      size: 70,
                      color: DefaultGreenColor,
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    child: Container(
                      width: 200,
                      child: Center(
                          child:
                              Text('900x900', style: PlaceholderTextAddItem)),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: ScreenPadding),
        ],
      ),
    );
  }
}
