import 'dart:async';

class MultiSelectValuesStream {
  StreamController _controller = StreamController<List>.broadcast();
  List values = [];

  Function get add => _controller.sink.add;
  Stream get stream => _controller.stream;

  MultiSelectValuesStream() {
    stream.listen((event) => values = event);
  }

  void dispose() {
    _controller.close();
  }
}
