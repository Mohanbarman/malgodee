import 'package:ShoppingApp/bloc/product_flow_bloc.dart';
import 'package:ShoppingApp/screens/add_brand/add_brand.dart';
import 'package:ShoppingApp/screens/all_brands/all_brands.dart';
import 'package:ShoppingApp/screens/edit_brand/edit_brand.dart';
import 'package:ShoppingApp/widgets/crud_form/local_screens/category_and_brand_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/all_products/all_products.dart';
import 'screens/edit_offer/edit_offer.dart';
import 'screens/home/home.dart';
import 'screens/add_offer/add_offer.dart';
import 'screens/all_offers/all_offers.dart';
import 'screens/edit_category/edit_category.dart';
import 'screens/login/login.dart';
import 'screens/all_categories/all_categories.dart';
import 'screens/product_crud/proudct_crud.dart';
import 'screens/products/product_info.dart';
import 'screens/add_category/add_category.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        productFlowBloc.clear();
        return FadeRoute(page: Home());
      case '/offers':
        return FadeRoute(page: Offers());
      case '/login':
        return FadeRoute(page: Login());
      case '/allcategories':
        return FadeRoute(page: AllCategories());
      case '/allbrands':
        return FadeRoute(page: AllBrands());
      case '/productinfo':
        return FadeRoute(page: ProductInfo());
      case '/addcategory':
        return FadeRoute(page: AddCategory());
      case '/addbrand':
        return FadeRoute(page: AddBrand());
      case '/addoffer':
        return FadeRoute(page: AddOffer());
      case '/editbrand':
        return FadeRoute(page: EditBrand(brandModel: args));
      case '/editcategory':
        return FadeRoute(page: EditCategory(categoryModel: args));
      case '/editoffer':
        return FadeRoute(page: EditOffer(offerModel: args));
      case '/allproducts':
        return FadeRoute(
          page:
              AllProducts(searchBy: args != null ? args['searchQuery'] : null),
        );
      case '/addproduct':
        return FadeRoute(page: ProductCrud());
      case '/editproduct':
        if (args == null)
          throw 'A product model is required for EditProduct screen';
        return FadeRoute(page: ProductCrud(model: args));
      case '/selectCategoryAndBrand':
        return FadeRoute(
            page: CategoryAndBrandSelector(
          dropdownBrandBloc: args['dropdownBrandBloc'],
          categoryPickerBloc: args['categoryPickerBloc'],
        ));
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
