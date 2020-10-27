import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';

class ProductHighlightsSection extends StatelessWidget {
  final List _highlights;
  ProductHighlightsSection(this._highlights);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenPadding),
      child: Column(
        children: [
          Row(children: [Text('Highlights', style: HightlightsTitleStyle)]),
          SizedBox(height: ScreenPadding),
          ..._highlights.map(
            (highlight) => Container(
              padding: EdgeInsets.only(left: ScreenPadding * 2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: ScreenPadding / 2),
                child: Row(
                  children: [
                    Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: AccentColor, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    SizedBox(width: ScreenPadding),
                    Text(highlight, style: HighlightBodyTextStyle),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
