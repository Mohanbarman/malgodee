import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'package:ShoppingApp/models/category.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/underlined_text.dart';
import '../../widgets/custom_grid.dart';
import '../../styles.dart';

class AllCategories extends StatelessWidget {
  final Map args;
  AllCategories(this.args);
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
                UnderlinedText('All categories'),
                StreamBuilder(
                  initialData: adminStreamController.initialData,
                  stream: adminStreamController.authStatusStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data == UserAuth.isAuthorized) {
                      return Button1(
                          title: 'Add category', route: '/addcategory');
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
                collection: 'categories',
              ),
              context: context,
              referer: 'category',
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
