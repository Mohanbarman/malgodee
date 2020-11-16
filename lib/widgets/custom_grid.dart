import 'package:ShoppingApp/widgets/shimmer_placeholders.dart';
import 'package:ShoppingApp/models/brand.dart';
import 'package:flutter/material.dart';
import 'rounded_icon_container.dart';

enum Referer { category, brand }

class CustomGridViewX4 extends StatelessWidget {
  final Stream itemsStream;
  final Widget lastWidget;
  final String referer;
  final BuildContext context;
  final Function onTap;
  final Function onLongPress;
  CustomGridViewX4({
    @required this.itemsStream,
    this.lastWidget,
    this.referer,
    this.context,
    this.onTap,
    this.onLongPress,
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

              if (lastWidget is Widget && index + 1 == itemCount)
                return lastWidget;

              if (index + 1 == itemCount) return SizedBox();

              String name = snapshot.data.docs[index]['name'];
              String image = snapshot.data.docs[index]['image'];

              print(image);

              return RoundedIconContainer(
                title: name,
                imageUrl: image,
                onLongPress: () {
                      onLongPress(
                        id: snapshot.data.docs[index].id,
                        name: snapshot.data.docs[index]['name'],
                        image: snapshot.data.docs[index]['image'],
                        description: snapshot.data.docs[index]['description'],
                      );
                    } ??
                    () {},
                onTap: onTap != null
                    ? () {
                        onTap();
                      }
                    : () {},
              );
            },
          );
        },
      ),
    );
  }
}
