import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:flutter/material.dart';
import 'rounded_icon_container.dart';

enum Referer { category, brand }

class CustomGridView extends StatelessWidget {
  final List items;
  final Widget lastWidget;
  final Referer referer;
  final BuildContext context;
  CustomGridView({
    this.items,
    this.lastWidget,
    this.referer,
    this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 30,
        children: allWIdgets(
          items: this.items,
          lastWidget: this.lastWidget,
        ),
      ),
    );
  }

  List<Widget> allWIdgets({List items, Widget lastWidget, String route}) {
    List allItems = items;
    List<Widget> allWidgets = allItems
        .map(
          (item) => RoundedIconContainer(
            title: item['title'],
            imagePath: item['imagePath'],
            onTap: () {
              productFlowBloc.productSink.add({'brand': item['id']});
              if (this.referer == Referer.brand) {
                if (productFlowBloc.productStreamRouteInfo['category'] ==
                    null) {
                  return Navigator.pushNamed(context, '/categories');
                } else {
                  return Navigator.pushNamed(
                    context,
                    '/productInfo',
                    arguments: productFlowBloc.productStreamRouteInfo,
                  );
                }
              }
              if (this.referer == Referer.category) {
                if (productFlowBloc.productStreamRouteInfo['brand'] == null) {
                  return Navigator.pushNamed(context, '/brands');
                } else {
                  return Navigator.pushNamed(
                    context,
                    '/productInfo',
                    arguments: productFlowBloc.productStreamRouteInfo,
                  );
                }
              }
            },
          ),
        )
        .toList();
    if (lastWidget is Widget) {
      allWidgets.add(lastWidget);
    }
    return (allWidgets);
  }
}
