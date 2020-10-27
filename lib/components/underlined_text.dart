import 'package:flutter/material.dart';
import '../styles.dart';

class UnderlinedText extends StatelessWidget {
  final String _title;
  UnderlinedText(
    this._title,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
          bottom: 6,
          right: -20,
          child: Container(
            height: 8,
            width: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: SecondaryColor,
            ),
          ),
        ),
        Text(_title, style: TitleTextStyle),
      ],
    );
  }

  noUnderline() {
    return (Text(_title, style: TitleTextStyle));
  }
}
