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

String searchValue;

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
    if (searchValue != null && searchValue.length > 0)
      _textEditingController = TextEditingController(text: searchValue);
    return Container(
      width: 300,
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
          onSubmitted: (value) {
            if (_textEditingController.value.text.length < 1) return 0;
            searchValue = _textEditingController.value.text;
            Navigator.pushNamed(context, '/allproducts', arguments: {
              'searchQuery': _textEditingController.value.text,
            });
          },
          decoration: InputDecoration(
            hintText: 'Search products',
            suffixIcon: Container(
              child: IconButton(
                splashRadius: 22,
                onPressed: () {
                  print(_textEditingController.value.text);
                  if (_textEditingController.value.text.length < 1) return 0;
                  searchValue = _textEditingController.value.text;
                  Navigator.pushNamed(context, '/allproducts', arguments: {
                    'searchQuery': _textEditingController.value.text,
                  });
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
    );
  }
}
