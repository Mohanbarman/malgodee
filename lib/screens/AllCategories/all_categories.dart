import 'package:ShoppingApp/components/bottom_navigation_bar.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShoppingApp/flavour.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../components/app_bar.dart';
import '../../components/underlined_text.dart';
import '../../components/custom_grid.dart';
import '../../styles.dart';

String categoryLogo = 'assets/images/fan-category.png';

List brands = [
  {'id': 1, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 2, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 3, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 4, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 5, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 6, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 7, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 8, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 9, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 10, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 11, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 12, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 13, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 14, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 15, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 16, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 17, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 18, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 19, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 20, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 21, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 22, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 23, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 24, 'title': 'Fans', 'imagePath': categoryLogo},
  {'id': 25, 'title': 'Fans', 'imagePath': categoryLogo},
];

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
        padding:
            EdgeInsets.fromLTRB(ScreenPadding, ScreenPadding, ScreenPadding, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('All categories'),
                Provider.of<User>(context) == User.authenticated
                    ? Button1('Add category', '/addcategory')
                    : SizedBox()
              ],
            ),
            SizedBox(height: 30),
            CustomGridView(brands),
          ],
        ),
      ),
    );
  }
}