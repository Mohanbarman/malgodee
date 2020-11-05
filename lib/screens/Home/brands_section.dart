import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/components/custom_grid.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/buttons.dart';
import 'package:ShoppingApp/components/underlined_text.dart';
import 'package:ShoppingApp/components/rounded_icon_container.dart';

String _brandsLogo1 = 'assets/images/sample-category.png';

List brands = [
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
  {'title': 'Usha', 'imagePath': _brandsLogo1},
];

class BrandsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnderlinedText('Brands'),
              StreamBuilder(
                initialData: adminStreamController.initialData,
                stream: adminStreamController.authStatusStream,
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
          SizedBox(height: 20),
          CustomGridViewX4(
            itemsStream: FirebaseStorageApi.streamOfCollection(
              collection: 'brands',
              limit: 10,
            ),
            lastWidget: RoundedIconContainer(
              title: 'All Brands',
              viewAllIcon: true,
              route: '/brands',
            ),
          ),
        ],
      ),
    );
  }
}
