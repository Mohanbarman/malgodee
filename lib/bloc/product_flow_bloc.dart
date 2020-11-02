import 'dart:async';

enum ProductRoute { clearData }

class ProductBloc {
  final StreamController _productController = StreamController.broadcast();
  final StreamController _productRouteState = StreamController.broadcast();
  Map productStreamRouteInfo = {'category': null, 'brand': null};

  void handleProductRouteData(data, sink) {
    if (data.containsKey('brand'))
      this.productStreamRouteInfo['brand'] = data['brand'];
    else if (data.containsKey('category'))
      this.productStreamRouteInfo['category'] = data['category'];
    sink.add(data);
  }

  void handleStateData(data, sink) {
    if (data == ProductRoute.clearData) {
      this.productStreamRouteInfo = {'category': null, 'brand': null};
    }
  }

  get productStream => _productController.stream
      .transform(StreamTransformer.fromHandlers(handleData: handleStateData));

  get routeStateStream => _productRouteState.stream.transform(
      StreamTransformer.fromHandlers(handleData: handleProductRouteData));

  get productSink => _productController.sink;
  get routeStateSink => _productRouteState.sink;

  void dispose() {
    _productController.close();
    _productRouteState.close();
  }
}

ProductBloc productFlowBloc = ProductBloc();
