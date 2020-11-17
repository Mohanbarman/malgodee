import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:ShoppingApp/widgets/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/custom_app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';

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
          Expanded(
            child: CustomGridView2x2(
              itemsStream: FirebaseStorageApi.streamOfCollection(
                collection: 'offers',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
