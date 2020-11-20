import 'package:ShoppingApp/screens/all_brands/all_brands.dart';
import 'package:ShoppingApp/screens/brand_category_crud/brand_category_crud.dart';
import 'package:ShoppingApp/screens/edit_brand/edit_brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/edit_offer/edit_offer.dart';
import 'screens/home/home.dart';
import 'screens/add_offer/add_offer.dart';
import 'screens/all_offers/all_offers.dart';
import 'screens/edit_category/edit_category.dart';
import 'screens/login/login.dart';
import 'screens/all_categories/all_categories.dart';
import 'screens/products/product_info.dart';
import 'screens/add_category/add_category.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return FadeRoute(page: Home());
      case '/offers':
        return FadeRoute(page: Offers());
      case '/login':
        return FadeRoute(page: Login());
      case '/allcategories':
        return FadeRoute(page: AllCategories(args));
      case '/allbrands':
        return FadeRoute(page: AllBrands());
      // case '/allproducts':
      //   return FadeRoute(page: AllProducts());
      case '/productinfo':
        return FadeRoute(page: ProductInfo());
      case '/addcategory':
        return FadeRoute(page: AddCategory());
      case '/addbrand':
        return FadeRoute(page: BrandCategoryCrud(typeOf: TypeOf.brand));
      case '/addoffer':
        return FadeRoute(page: AddOffer());
      // case '/addproduct':
      //   return FadeRoute(page: AddProduct());
      // case '/editproduct':
      //   if (args == null)
      //     throw 'A product model is required for EditProduct screen';
      //   return FadeRoute(page: EditProduct(model: args));
      case '/editbrand':
        return FadeRoute(page: BrandCategoryCrud(model: args));
      case '/editcategory':
        return FadeRoute(page: EditCategory(categoryModel: args));
      case '/editoffer':
        return FadeRoute(page: EditOffer(offerModel: args));
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

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
