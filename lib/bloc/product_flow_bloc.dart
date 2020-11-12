import 'dart:async';

enum ProductRoute { clearData }

class ProductBloc {
  final StreamController _productController = StreamController.broadcast();
  final StreamController _productRouteState = StreamController.broadcast();
  Map productStreamRouteInfo = {'category': null, 'brand': null};

  void _handleProductRouteData(data) {
    if (data.containsKey('brand'))
      this.productStreamRouteInfo['brand'] = data['brand'];
    else if (data.containsKey('category'))
      this.productStreamRouteInfo['category'] = data['category'];
    print(this.productStreamRouteInfo);
  }

  void _handleProductRouteState(data) {
    if (data == ProductRoute.clearData) {
      this.productStreamRouteInfo['brand'] = null;
      this.productStreamRouteInfo['category'] = null;
      print(this.productStreamRouteInfo);
    }
  }

  ProductBloc() {
    productStream.listen(_handleProductRouteData);
    routeStateStream.listen(_handleProductRouteState);
  }

  get productStream => _productController.stream;
  get routeStateStream => _productRouteState.stream;

  get productSink => _productController.sink;
  get routeStateSink => _productRouteState.sink;

  void dispose() {
    _productController.close();
    _productRouteState.close();
  }
}

ProductBloc productFlowBloc = ProductBloc();
