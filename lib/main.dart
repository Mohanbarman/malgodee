import 'package:ShoppingApp/bloc/admin_features.dart';
import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  adminStreamController.authStatusStream.listen(
    (event) => print(event),
  );
  productFlowBloc.productStream.listen(
    (_) => print(
      productFlowBloc.productStreamRouteInfo,
    ),
  );

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();

  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    adminStreamController.authStatusSink.add(UserAuth.isAuthorized);
  } else {
    adminStreamController.authStatusSink.add(UserAuth.unauthorized);
  }

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
