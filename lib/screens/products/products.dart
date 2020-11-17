import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';

class AllProudcts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
    );
  }
}
