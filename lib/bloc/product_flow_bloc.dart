import 'dart:async';
import 'package:flutter/widgets.dart';

class ProductBloc {
  final StreamController _productController = StreamController.broadcast();
  final StreamController _buildContextController =
      StreamController<BuildContext>.broadcast();

  Map productStreamRouteInfo = {'category': null, 'brand': null};
  BuildContext currentContext;

  _handleProductRouteData(data) {
    Map _data = Map.from(data);

    if (_data.containsKey('brand')) {
      this.productStreamRouteInfo['brand'] = _data['brand'];
      return 0;
    }
    if (_data.containsKey('category')) {
      this.productStreamRouteInfo['category'] = _data['category'];
      return 0;
    }
  }

  int _handleProductRoute() {
    if (this.productStreamRouteInfo['category'] != null &&
        this.productStreamRouteInfo['brand'] != null) {
      print(this.productStreamRouteInfo);
      Navigator.pushNamed(currentContext, '/allproducts');
      return 0;
    }

    if (this.productStreamRouteInfo['category'] != null) {
      Navigator.pushNamed(currentContext, '/allbrands');
      return 0;
    }

    if (this.productStreamRouteInfo['brand'] != null) {
      Navigator.pushNamed(currentContext, '/allcategories');
      return 0;
    }

    return 0;
  }

  void _handleBuildContext(data) {
    currentContext = data;
  }

  ProductBloc() {
    productStream.listen((e) {
      _handleProductRouteData(e);
      _handleProductRoute();
    });

    addContextStream.listen(_handleBuildContext);
  }

  get productStream => _productController.stream;

  void add(BuildContext context, Map<String, dynamic> data) {
    _buildContextController.sink.add(context);
    _productController.sink.add(data);
  }

  void clear() {
    productStreamRouteInfo = {'brand': null, 'category': null};
  }

  Function(BuildContext) get addContext => _buildContextController.sink.add;
  Stream get addContextStream => _buildContextController.stream;

  void dispose() {
    _productController.close();
    _buildContextController.close();
  }
}

ProductBloc productFlowBloc = ProductBloc();
