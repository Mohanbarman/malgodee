import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/widgets/custom_grid.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/buttons.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:ShoppingApp/widgets/rounded_icon_container.dart';

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
          CustomGridView4x4(
            itemsStream: FirebaseStorageApi.streamOfCollection(
              collection: 'brands',
              limit: 10,
            ),
            onTap: (id) {
              productFlowBloc.add(context, {'brand': id});
            },
            referer: Referer.brand,
            lastWidget: RoundedIconContainer(
              title: 'All Brands',
              viewAllIcon: true,
              route: '/allbrands',
            ),
          ),
        ],
      ),
    );
  }
}
