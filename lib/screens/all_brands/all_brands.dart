import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../components/app_bar.dart';
import '../../components/bottom_navigation_bar.dart';
import '../../components/underlined_text.dart';
import '../../components/custom_grid.dart';

const String _brandsLogo1 = 'assets/images/sample-category.png';

List brands = [
  {'id': 1, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 2, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 3, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 4, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 5, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 6, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 7, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 8, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 9, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 11, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 12, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 13, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 14, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 15, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 16, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 17, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 18, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 19, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 20, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 21, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 22, 'title': 'Usha', 'imagePath': _brandsLogo1},
  {'id': 23, 'title': 'Usha', 'imagePath': _brandsLogo1},
];

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
        padding:
            EdgeInsets.fromLTRB(ScreenPadding, ScreenPadding, ScreenPadding, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UnderlinedText('All brands'),
                StreamBuilder(
                  stream: adminStreamController.authStatusStream,
                  initialData: adminStreamController.initialData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == UserAuth.isAuthorized) {
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
              items: brands,
              referer: Referer.brand,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
