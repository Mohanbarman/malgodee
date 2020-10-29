import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../styles.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int _selected_index;
  CustomBottomNavigationBar(this._selected_index);
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState(_selected_index);
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selected_index;
  _CustomBottomNavigationBarState(this._selected_index);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AccentColor,
      height: 55,
      child: Row(
        children: [
          createIconButton(Icons.phone, 'Phone', 0, '/products', context),
          createIconButton(Icons.chat_bubble, 'Chat', 1, '/chat', context),
          createIconButton(Icons.local_offer, 'Offer', 2, '/offers', context),
          createIconButton(Icons.home_filled, 'Home', 3, '/', context),
        ],
      ),
    );
  }

  Widget createIconButton(
      IconData icon, String label, int index, route, context) {
    print(_selected_index);
    List<Widget> widgets = <Widget>[
      Positioned(
        top: -3.5,
        child: Container(
          height: 5,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            color: index == _selected_index ? Colors.white : AccentColor,
          ),
        ),
      ),
      IconButton(
        icon: Icon(icon),
        onPressed: () {
          setState(() {
            Navigator.pushNamed(context, route);
            _selected_index = index;
          });
        },
        color: index == _selected_index ? Colors.white : Colors.white60,
      ),
    ];

    return Expanded(
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: widgets,
      ),
    );
  }
}
