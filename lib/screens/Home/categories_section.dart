import 'package:ShoppingApp/auth.dart';
import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/underlined_text.dart';
import '../../components/rounded_icon_container.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../styles.dart';

class CategoriesSection extends StatelessWidget {
  final String _categorySampleImage = 'assets/images/fan-category.png';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText("Categories"),
                StreamBuilder(
                  initialData: adminStreamController.initialData,
                  stream: adminStreamController.authStatusStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1('Add category', '/addcategory');
                    } else if (snapshot.data == UserAuth.unauthorized) {
                      return SizedBox();
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 90.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                SizedBox(width: ScreenPadding),
                for (int i = 0; i < 8; i++)
                  Row(children: [
                    RoundedIconContainer('Fan', _categorySampleImage),
                    SizedBox(width: 30)
                  ]),
                RoundedIconContainer(
                    'All Categories', null, true, '/categories'),
                SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
