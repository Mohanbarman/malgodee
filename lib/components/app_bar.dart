import 'package:ShoppingApp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

PreferredSize CustomAppBar() {
  return PreferredSize(
    child: Bar(),
    preferredSize: Size.fromHeight(70.0),
  );
}

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [SearchBar()],
      toolbarHeight: 200.0,
      leading: IconButton(
        splashRadius: 25,
        icon: Icon(
          Icons.menu,
          color: DefaultFontColor,
        ),
        onPressed: () {
          if (Authentication.isAuthenticated()) {
            return showAlertDialog(context);
          }
          Navigator.pushNamed(context, '/login');
        },
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget logoutButton = FlatButton(
      color: DefaultRedColor,
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/');
      },
      child: Text('Logout'),
    );

    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel'),
    );

    AlertDialog alert = AlertDialog(
      title: Text('Logout'),
      content: Text('Do you want to logout ?'),
      actions: [cancelButton, logoutButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // padding: EdgeInsets.only(left: 20),
      margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black12,
            offset: Offset.infinite,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: TextField(
          cursorColor: AccentColor,
          decoration: InputDecoration(
            hintText: 'Search products',
            suffixIcon: Container(
              child: IconButton(
                splashRadius: 22,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: DefaultFontColor,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(left: 30, top: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
