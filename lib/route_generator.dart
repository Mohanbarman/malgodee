import 'package:ShoppingApp/editing_screens/edit_category.dart';
import 'package:ShoppingApp/editing_screens/edit_offer_screen.dart';
import 'package:ShoppingApp/screens/all_brands/all_brands.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/Home/home.dart';
import 'screens/all_offers/all_offers.dart';
import 'screens/login/login.dart';
import 'screens/AllCategories/all_categories.dart';
import 'screens/products/products.dart';
import 'screens/products/product_info.dart';
import 'screens/add_elements/add_category.dart';
import 'screens/add_elements/add_brand.dart';
import 'screens/add_elements/add_offer.dart';
import 'screens/add_elements/add_product.dart';
import 'screens/add_elements/edit_product.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return NoAnimationMaterialPageRoute(builder: (_) => Home());
      case '/offers':
        return NoAnimationMaterialPageRoute(builder: (_) => Offers());
      case '/login':
        return NoAnimationMaterialPageRoute(builder: (_) => Login());
      case '/allcategories':
        return NoAnimationMaterialPageRoute(
          builder: (_) => AllCategories(args),
        );
      case '/allbrands':
        return NoAnimationMaterialPageRoute(builder: (_) => AllBrands(args));
      case '/allproducts':
        return NoAnimationMaterialPageRoute(
          builder: (_) => AllProducts(),
        );
      case '/productinfo':
        return NoAnimationMaterialPageRoute(
          builder: (_) => ProductInfo(),
        );
      case '/addcategory':
        return NoAnimationMaterialPageRoute(builder: (_) => AddCategory());
      case '/addbrand':
        return NoAnimationMaterialPageRoute(builder: (_) => AddBrand());
      case '/addoffer':
        return NoAnimationMaterialPageRoute(builder: (_) => AddOffer());
      case '/addproduct':
        return NoAnimationMaterialPageRoute(builder: (_) => AddProduct());
      case '/editproduct':
        if (args == null) {
          throw 'A product model is required for EditProduct screen';
        }
        return NoAnimationMaterialPageRoute(
          builder: (_) => EditProduct(model: args),
        );
      case '/editoffer':
        return NoAnimationMaterialPageRoute(
            builder: (_) => EditOffer(model: args));
      case '/editcategory':
        return NoAnimationMaterialPageRoute(
          builder: (_) => EditCategory(
            categoryModel: args,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            title: Text('Error 404'),
            backgroundColor: Colors.black38,
          ),
          body: Center(
            child: Container(
              child: Text(
                'Something went wrong Page not found :(',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
