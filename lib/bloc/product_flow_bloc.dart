import 'dart:async';

Map routeInfo = {'category': null, 'brand': null};

enum ProductRoute { clearData }

class ProductFlow {
  final StreamController _productController = StreamController.broadcast();
  final StreamController _productRouteState = StreamController.broadcast();

  final _calcRoute = StreamTransformer.fromHandlers(
    // ignore: top_level_function_literal_block
    handleData: (Map<String, int> data, sink) {
      if (data.containsKey('brand'))
        routeInfo['brand'] = data['brand'];
      else if (data.containsKey('category'))
        routeInfo['category'] = data['category'];
      sink.add(data);

      if (data['brand'] is int && data['category'] is int) {
        print('');
      }
    },
  );

  final _routeStateHandler = StreamTransformer.fromHandlers(
    // ignore: top_level_function_literal_block
    handleData: (ProductRoute data, sink) {
      if (data == ProductRoute.clearData) {
        routeInfo = {'category': null, 'brand': null};
      }
    },
  );

  ProductFlow() {
    routeStateStream.listen((e) => print(e));
  }

  Stream get productStream => _productController.stream.transform(_calcRoute);
  Stream get routeStateStream =>
      _productRouteState.stream.transform(_routeStateHandler);
  Sink get productSink => _productController.sink;
  Sink get routeStateSink => _productRouteState.sink;

  void dispose() {
    _productController.close();
    _productRouteState.close();
  }
}
