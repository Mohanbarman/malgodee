import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/rounded_icon_container.dart';
import 'package:ShoppingApp/components/buttons.dart';
import 'package:ShoppingApp/styles.dart';

List categories = [
  {'id': 1, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 2, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 3, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 4, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 5, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 6, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 7, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 8, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
  {'id': 9, 'title': 'fan', 'image': 'assets/images/fan-category.png'},
];

class CategoriesSection extends StatelessWidget {
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
                      return Button1(
                          title: 'Add category', route: '/addcategory');
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
                ...categories.map(
                  (e) => Row(
                    children: [
                      RoundedIconContainer(
                        title: 'Fan',
                        imagePath: e['image'],
                        onTap: () {
                          productFlowBloc.productSink
                              .add({'category': e['id']});
                          Navigator.pushNamed(context, '/brands');
                        },
                      ),
                      SizedBox(width: 30)
                    ],
                  ),
                ),
                RoundedIconContainer(
                  title: 'All Categories',
                  viewAllIcon: true,
                  route: '/categories',
                ),
                SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
