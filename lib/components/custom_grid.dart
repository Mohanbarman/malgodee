import 'package:flutter/material.dart';
import 'rounded_icon_container.dart';

class CustomGridView extends StatelessWidget {
  final List _items;
  Widget _lastWidget;
  CustomGridView(this._items, [this._lastWidget]);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: GridView.count(
        crossAxisCount: 4,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        // primary: true,
        mainAxisSpacing: 30,
        children: allWIdgets(_items, lastWidget: _lastWidget),
      ),
    );
  }

  List<Widget> allWIdgets(List items, {Widget lastWidget, String route}) {
    List allItems = items;
    List<Widget> allWidgets = allItems
        .map((item) => RoundedIconContainer(item['title'], item['imagePath']))
        .toList();
    if (lastWidget is Widget) {
      allWidgets.add(lastWidget);
    }
    return (allWidgets);
  }
}
