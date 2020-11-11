import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';
import 'package:ShoppingApp/models/brand.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/shared/localstorage.dart';
import 'package:flutter/material.dart';
import 'rounded_icon_container.dart';

enum Referer { category, brand }

class CustomGridViewX4 extends StatelessWidget {
  final Stream itemsStream;
  final Widget lastWidget;
  final Referer referer;
  final BuildContext context;
  CustomGridViewX4({
    @required this.itemsStream,
    this.lastWidget,
    this.referer,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: this.itemsStream,
        builder: (context, snapshot) {
          int itemCount =
              snapshot.hasData == true ? snapshot.data.docs.length + 1 : 11;
          return GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              if (!snapshot.hasData) return CategoriesImagePlaceholder();

              if (lastWidget is Widget && index + 1 == itemCount) {
                return lastWidget;
              }

              if (index + 1 == itemCount) {
                return SizedBox();
              }

              String name = snapshot.data.docs[index]['name'];
              String imagePath = snapshot.data.docs[index]['image'];
              String id = snapshot.data.docs[index].id;

              return FutureBuilder(
                // future: FirebaseStorageApi.futureFromImagePath(imagePath),
                future: LocalStorage.loadData(
                  model: BrandModel(
                    name: name,
                    image: imagePath,
                    id: id,
                  ),
                ),
                builder: (context, snapshot1) {
                  if (!snapshot1.hasData) return CategoriesImagePlaceholder();
                  return RoundedIconContainer(
                    title: name,
                    bytes: snapshot1.data,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
