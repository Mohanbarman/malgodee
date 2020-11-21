import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/widgets/offer_image_container.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'rounded_icon_container.dart';

enum Referer { category, brand }

class CustomGridView4x4 extends StatelessWidget {
  final Function onLongPress;
  final Stream itemsStream;
  final Widget lastWidget;
  final Referer referer;
  final Function onTap;

  final List filterByIds;
  String refererStr;

  CustomGridView4x4({
    @required this.itemsStream,
    this.referer,
    this.lastWidget,
    this.onTap,
    this.onLongPress,
    this.filterByIds,
  });

  @override
  Widget build(BuildContext context) {
    if (referer == Referer.brand) refererStr = 'brand';
    if (referer == Referer.category) refererStr = 'category';

    return Container(
      /* Stream of all items */
      child: StreamBuilder(
        stream: this.itemsStream,
        builder: (context, itemSnapshot) {
          int itemCount = itemSnapshot.hasData == true
              ? itemSnapshot.data.docs.length + 1
              : 11;

          if (!(filterByIds == null)) {
            itemCount = filterByIds.length + 1;
          }
          /* Stream of referer document (single) */
          return GridView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              if (!itemSnapshot.hasData) return SizedBox();
              if (lastWidget is Widget && index + 1 == itemCount)
                return lastWidget;
              if (index + 1 == itemCount) return SizedBox();

              List _docs = itemSnapshot.data.docs.toList();

              if (filterByIds != null) {
                _docs =
                    List.from(_docs.where((e) => filterByIds.contains(e.id)));
              }

              String name = _docs[index]['name'];
              String image = _docs[index]['image'];
              String id = _docs[index].id;

              return RoundedIconContainer(
                title: name,
                imageUrl: image,
                onTap: () {
                  onTap(id);
                },
                onLongPress: () {
                      onLongPress(
                        id: id,
                        name: name,
                        image: image,
                        description: itemSnapshot.data.docs[index]
                            ['description'],
                      );
                    } ??
                    () {},
              );
            },
          );
        },
      ),
    );
  }
}

class CustomGridView2x2 extends StatelessWidget {
  final Stream itemsStream;
  final Function onTap;
  final Function onLongPress;

  CustomGridView2x2({this.itemsStream, this.onTap, this.onLongPress});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemsStream,
      builder: (context, itemSnapshot) {
        if (!itemSnapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ScreenPadding,
            mainAxisSpacing: ScreenPadding,
          ),
          shrinkWrap: true,
          itemCount: itemSnapshot.data.docs.length,
          padding: EdgeInsets.all(ScreenPadding),
          itemBuilder: (context, index) {
            return OfferImageContainer(
              onLongPress: () {
                onLongPress(
                  id: itemSnapshot.data.docs[index].id,
                  name: itemSnapshot.data.docs[index]['name'],
                  image: itemSnapshot.data.docs[index]['image'],
                  description: itemSnapshot.data.docs[index]['description'],
                );
              },
              imageUrl: itemSnapshot.data.docs[index]['image'],
            );
          },
        );
      },
    );
  }
}
