import 'dart:async';

class DropdownBrandBloc {
  StreamController _controller = StreamController.broadcast();
  String currValue;

  get stream => _controller.stream;
  get add => _controller.sink.add;

  DropdownBrandBloc() {
    stream.listen((e) => currValue = e);
  }

  void dispose() {
    _controller.close();
  }
}
