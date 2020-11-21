import 'package:ShoppingApp/services/firestore_api.dart';
import 'package:ShoppingApp/utils/wp_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ShoppingApp/utils/make_call.dart';
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
          StreamBuilder(
              stream: FirebaseStorageApi.streamOfCollection(
                collection: 'calling_number',
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return SizedBox();
                return createIconButton(
                  icon: Icons.phone,
                  label: 'Phone',
                  index: 0,
                  context: context,
                  onPress: () => makeCall(
                    number: snapshot.data.docs[0]['phone_number'],
                  ),
                );
              }),
          StreamBuilder(
              stream: FirebaseStorageApi.streamOfCollection(
                collection: 'whatsapp_number',
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return SizedBox();
                return createIconButton(
                  icon: Icons.chat_bubble,
                  label: 'Chat',
                  index: 1,
                  context: context,
                  onPress: () => openWhatsapp(
                    number: snapshot.data.docs[0]['phone_number'],
                  ),
                );
              }),
          createIconButton(
            icon: Icons.local_offer,
            label: 'Offer',
            index: 2,
            route: '/offers',
            context: context,
          ),
          createIconButton(
            icon: Icons.home_filled,
            label: 'Home',
            index: 3,
            route: '/',
            context: context,
          ),
        ],
      ),
    );
  }

  Widget createIconButton({
    IconData icon,
    String label,
    int index,
    String route,
    BuildContext context,
    Function onPress,
  }) {
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
        onPressed: onPress ??
            () {
              setState(
                () {
                  Navigator.pushReplacementNamed(context, route);
                  _selected_index = index;
                },
              );
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
