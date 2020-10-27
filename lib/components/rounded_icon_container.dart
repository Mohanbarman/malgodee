import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../styles.dart';

class RoundedIconContainer extends StatelessWidget {
  final String _title;
  final String _imagePath;
  String _route;
  bool _viewAllIcon = false;

  RoundedIconContainer(this._title, this._imagePath,
      [this._viewAllIcon, this._route]);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: _viewAllIcon == true
                ? IconButton(
                    icon: Icon(FeatherIcons.grid, color: DefaultFontColor),
                    onPressed: () {
                      if (_route != null) Navigator.pushNamed(context, _route);
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      if (_route != null) Navigator.pushNamed(context, _route);
                    },
                    child: Image(
                      image: AssetImage(_imagePath),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
          ),
          SizedBox(height: 10),
          Text(_title, style: BodyTextStyle1)
        ],
      ),
    );
  }
}
