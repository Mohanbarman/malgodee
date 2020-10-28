import 'package:ShoppingApp/auth.dart';
import 'package:ShoppingApp/components/custom_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ShoppingApp/flavour.dart';
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
              Authentication.isAuthenticated()
                  ? Button1('Add brand', '/addbrand')
                  : SizedBox()
            ],
          ),
          SizedBox(height: 20),
          CustomGridView(brands,
              RoundedIconContainer('All Brands', null, true, '/brands')),
        ],
      ),
    );
  }
}
