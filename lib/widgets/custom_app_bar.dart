import 'package:ShoppingApp/auth.dart';
import 'package:ShoppingApp/bloc/admin_features.dart';
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
      onPressed: () {
        FirebaseAuth.instance.signOut();
        adminStreamController.authStatusSink.add(UserAuth.unauthorized);
        Navigator.pop(context);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: DefaultRedColor,
            content: Text('Signed out'),
          ),
        );
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
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/searchproduct'),
      child: Container(
        width: 300,
        // padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.fromLTRB(0, 10, 40, 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black12,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: TextField(
            cursorColor: AccentColor,
            controller: _textEditingController,
            onChanged: print,
            decoration: InputDecoration(
              hintText: 'Search products',
              suffixIcon: Container(
                child: IconButton(
                  splashRadius: 22,
                  onPressed: () {
                    print(_textEditingController.value.text);
                  },
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
      ),
    );
  }
}
