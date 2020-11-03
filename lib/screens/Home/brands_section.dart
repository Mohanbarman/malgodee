import 'package:ShoppingApp/auth.dart';
import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/components/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/components/buttons.dart';
import '../../components/underlined_text.dart';
import '../../components/rounded_icon_container.dart';

String _brandsLogo1 = 'assets/images/sample-category.png';

int _gridElementCount = 12;

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
                // initialData: UserAuth.unauthorized,
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
          CustomGridView(
            items: brands,
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
