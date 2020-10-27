import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'route_generator.dart';
import 'flavour.dart';

void main() {
  runApp(
    Provider<User>.value(
      value: User.authenticated,
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(
        accentColor: AccentColor,
        appBarTheme: MyAppBarTheme,
        backgroundColor: BackgroundColor,
        iconTheme: AppBarLeadingIconTheme,
        scaffoldBackgroundColor: BackgroundColor,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
