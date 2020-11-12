import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../components/app_bar.dart';
import '../../components/underlined_text.dart';
import '../../components/custom_grid.dart';
import '../../styles.dart';

class AllBrands extends StatelessWidget {
  final Map args;
  AllBrands(this.args);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      backgroundColor: BackgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenPadding,
          ScreenPadding,
          ScreenPadding,
          0,
        ),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('All brands'),
                StreamBuilder(
                  initialData: adminStreamController.initialData,
                  stream: adminStreamController.authStatusStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1(title: 'Add brand', route: '/addbrand');
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            CustomGridViewX4(
              itemsStream: FirebaseStorageApi.streamOfCollection(
                collection: 'brands',
              ),
              context: context,
              referer: 'brand',
              onLongPress: ({
                String id,
                String name,
                String image,
                String description,
              }) {
                Navigator.pushNamed(
                  context,
                  '/editcategory',
                  arguments: CategoryModel(
                    id: id,
                    name: name,
                    image: image,
                    description: description,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
