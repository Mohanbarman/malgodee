import 'dart:async';

import 'package:flutter/widgets.dart';

enum ProductRoute { clearData }

class ProductBloc {
  final StreamController _productController = StreamController.broadcast();
  final StreamController _productRouteState = StreamController.broadcast();
  final StreamController _buildContextController =
      StreamController<BuildContext>.broadcast();

  Map productStreamRouteInfo = {'category': null, 'brand': null};
  BuildContext currentContext;

  void _handleProductRouteData(Map data) {
    if (data.containsKey('brand') && data.containsKey('category'))
      Navigator.pushNamed(currentContext, '/allproducts');

    if (data.containsKey('brand')) {
      this.productStreamRouteInfo['brand'] = data['brand'];
      Navigator.pushNamed(currentContext, '/allcategories');
    }
    if (data.containsKey('category')) {
      this.productStreamRouteInfo['category'] = data['category'];
      Navigator.pushNamed(currentContext, '/allbrands');
    }
    print(this.productStreamRouteInfo);
  }

  void _handleProductRouteState(data) {
    if (data == ProductRoute.clearData) {
      this.productStreamRouteInfo['brand'] = null;
      this.productStreamRouteInfo['category'] = null;
      print(this.productStreamRouteInfo);
    }
  }

  void _handleBuildContext(data) {
    currentContext = data;
  }

  ProductBloc() {
    productStream.listen(_handleProductRouteData);
    routeStateStream.listen(_handleProductRouteState);
    addContextStream.listen(_handleBuildContext);
  }

  get productStream => _productController.stream;
  get routeStateStream => _productRouteState.stream;

  get productSink => _productController.sink;
  get routeStateSink => _productRouteState.sink;

  Function(BuildContext) get addContext => _buildContextController.sink.add;
  Stream get addContextStream => _buildContextController.stream;

  void dispose() {
    _productController.close();
    _productRouteState.close();
    _buildContextController.close();
  }
}

ProductBloc productFlowBloc = ProductBloc();
